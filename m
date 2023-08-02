Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953A576CAFB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjHBKhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjHBKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:36:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03BD4490;
        Wed,  2 Aug 2023 03:32:40 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22E0566018CF;
        Wed,  2 Aug 2023 11:32:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690972359;
        bh=/7pQ+RL+C9IsOxEUKck+Ky/01nkzrjWwtJzBRApAFFg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FSPr7IDaJUZI8qae4UT7rbflUxVKpkNX71m4yCF5Ruhxl/K4k5yyEdDxEQkQccg9k
         qDCrpbpi6aumO2kervMVnEQq432YsYqfYdS160+3UTkYZiNBUr3te5/PO0PzOSsSis
         ioBQTiDXnuTlca51tOlHBJzoOBnrEsg8bQ3z7jcsS5qPjVIKWfQePpct+eFJDw99be
         RW746hV1YiZIkVkK9FOJnpsgOOGL1qUqC4dUwbjywXrTA0DkjPt4VGh4oNU7fdwr/P
         3f9lzB2BzLVkwByQNV++CgFAla1k/rgVOBc5Gi/57J1Q2HEy+7tXrh5F35M3xkuAlP
         0xOcVABb4VkwA==
Message-ID: <a410f098-af13-435d-688c-1021cc7b8cbb@collabora.com>
Date:   Wed, 2 Aug 2023 12:32:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] mm-unstable: Multi-gen LRU: Fix per-zone reclaim
Content-Language: en-US
To:     Kalesh Singh <kaleshsingh@google.com>, yuzhao@google.com,
        akpm@linux-foundation.org
Cc:     surenb@google.com, android-mm@google.com, kernel-team@android.com,
        stable@vger.kernel.org,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        Barry Song <baohua@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230802025606.346758-1-kaleshsingh@google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230802025606.346758-1-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/08/23 04:56, Kalesh Singh ha scritto:
> MGLRU has a LRU list for each zone for each type (anon/file) in each
> generation:
> 
> 	long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
> The min_seq (oldest generation) can progress independently for each
> type but the max_seq (youngest generation) is shared for both anon and
> file. This is to maintain a common frame of reference.
> 
> In order for eviction to advance the min_seq of a type, all the per-zone
> lists in the oldest generation of that type must be empty.
> 
> The eviction logic only considers pages from eligible zones for
> eviction or promotion.
> 
>      scan_folios() {
> 	...
> 	for (zone = sc->reclaim_idx; zone >= 0; zone--)  {
> 	    ...
> 	    sort_folio(); 	// Promote
> 	    ...
> 	    isolate_folio(); 	// Evict
> 	}
> 	...
>      }
> 
> Consider the system has the movable zone configured and default 4
> generations. The current state of the system is as shown below
> (only illustrating one type for simplicity):
> 
> Type: ANON
> 
> 	Zone    DMA32     Normal    Movable    Device
> 
> 	Gen 0       0          0        4GB         0
> 
> 	Gen 1       0        1GB        1MB         0
> 
> 	Gen 2     1MB        4GB        1MB         0
> 
> 	Gen 3     1MB        1MB        1MB         0
> 
> Now consider there is a GFP_KERNEL allocation request (eligible zone
> index <= Normal), evict_folios() will return without doing any work
> since there are no pages to scan in the eligible zones of the oldest
> generation. Reclaim won't make progress until triggered from a ZONE_MOVABLE
> allocation request; which may not happen soon if there is a lot of free
> memory in the movable zone. This can lead to OOM kills, although there
> is 1GB pages in the Normal zone of Gen 1 that we have not yet tried to
> reclaim.
> 
> This issue is not seen in the conventional active/inactive LRU since
> there are no per-zone lists.
> 
> If there are no (not enough) folios to scan in the eligible zones, move
> folios from ineligible zone (zone_index > reclaim_index) to the next
> generation. This allows for the progression of min_seq and reclaiming
> from the next generation (Gen 1).
> 
> Qualcomm, Mediatek and raspberrypi [1] discovered this issue independently.
> 
> [1] https://github.com/raspberrypi/linux/issues/5395
> 
> Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
> Cc: stable@vger.kernel.org
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Reported-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Whole series tested on MT8173 Elm Chromebook and MT6795 Xperia M5 as those are
low ram devices. Can't reproduce the issue described in your [1] link from RPi.

MediaTek:
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> 
> Changes in v2:
>    - Add Fixes tag and cc stable
> 
>   mm/vmscan.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4039620d30fe..489a4fc7d9b1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4889,7 +4889,8 @@ static int lru_gen_memcg_seg(struct lruvec *lruvec)
>    *                          the eviction
>    ******************************************************************************/
>   
> -static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
> +static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_control *sc,
> +		       int tier_idx)
>   {
>   	bool success;
>   	int gen = folio_lru_gen(folio);
> @@ -4939,6 +4940,13 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
>   		return true;
>   	}
>   
> +	/* ineligible */
> +	if (zone > sc->reclaim_idx) {
> +		gen = folio_inc_gen(lruvec, folio, false);
> +		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
> +		return true;
> +	}
> +
>   	/* waiting for writeback */
>   	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
>   	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
> @@ -4987,7 +4995,8 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
>   static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>   		       int type, int tier, struct list_head *list)
>   {
> -	int gen, zone;
> +	int i;
> +	int gen;
>   	enum vm_event_item item;
>   	int sorted = 0;
>   	int scanned = 0;
> @@ -5003,9 +5012,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>   
>   	gen = lru_gen_from_seq(lrugen->min_seq[type]);
>   
> -	for (zone = sc->reclaim_idx; zone >= 0; zone--) {
> +	for (i = MAX_NR_ZONES; i > 0; i--) {
>   		LIST_HEAD(moved);
>   		int skipped = 0;
> +		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
>   		struct list_head *head = &lrugen->folios[gen][type][zone];
>   
>   		while (!list_empty(head)) {
> @@ -5019,7 +5029,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>   
>   			scanned += delta;
>   
> -			if (sort_folio(lruvec, folio, tier))
> +			if (sort_folio(lruvec, folio, sc, tier))
>   				sorted += delta;
>   			else if (isolate_folio(lruvec, folio, sc)) {
>   				list_add(&folio->lru, list);

