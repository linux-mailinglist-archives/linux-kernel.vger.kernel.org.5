Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45167801D0C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjLBNcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:32:04 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1181107;
        Sat,  2 Dec 2023 05:32:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701523896; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=GCwTnRFk6e80ShO3FX6v7rdJQSMX0/X1ovgySTMGf+n+RcIoiWf/xObfJcHxnq8gKodT31SK4Q/lMd9etxZXLBSwa+PMq8iEpXzw1lOjDT/YcTsWQF1oU/TKqAK/ZYPpL5HE1+SWyIfiICar7sh2ikKp0IyLwRz34of83WrrwtI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1701523896; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=8/lJzpQ0l1BXHMNEoi4VijDBQ6ZH4sNvHefkNZ5BWIg=; 
        b=J/jZRMh9jwQWchU5mwN1r6kze5pzBmXb0lnERl8FI1Ks+nKKDEvGVlayonl0GyUw1EDoKz0vc/F5S3MCShIcD+iN694l0q3AOWbjjeGz49nu45BRh27UbQ7u9A2MBATQbhoFQ1lKfnNOkpvUGr/T37uIOk+c4jFcldwjrW9QftQ=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701523896;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=8/lJzpQ0l1BXHMNEoi4VijDBQ6ZH4sNvHefkNZ5BWIg=;
        b=nn5VIFBf8sEFJbAUnNZKhWK8SW/lMvGaBuDXlZXoGxJy70UGKOWl4OVuaWxRSYfk
        C+p8z0l9ReNbOcv7f7uMRR7auhhG+vn1x+2U5UwWAFFaxeI9hz/GzYd5NtMMNJrYntW
        lyzCgi7hdQgI/4wShA2fUJgjIJhiyd6CLWA57y60=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1701523864503746.4314823257985; Sat, 2 Dec 2023 19:01:04 +0530 (IST)
Date:   Sat, 02 Dec 2023 19:01:04 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "netdev" <netdev@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <18c2ab9bba5.26abdb8f38744.5002982123699219766@siddh.me>
In-Reply-To: <ae2aae77-c194-4924-b698-4a499eabec5d@linaro.org>
References: <cover.1700943019.git.code@siddh.me>
 <ba18da37e48b5c473e5b8bd76d6460017342f968.1700943019.git.code@siddh.me> <ae2aae77-c194-4924-b698-4a499eabec5d@linaro.org>
Subject: Re: [PATCH 1/4] nfc: Extract nfc_dev access from
 nfc_alloc_send_skb() into the callers
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 15:40:51 +0530, Krzysztof Kozlowski wrote:
> On 25/11/2023 21:26, Siddh Raman Pant wrote:
> > The only reason why nfc_dev was accessed inside nfc_alloc_send_skb() is
> > for getting the headroom and tailroom values.
> > 
> > This can cause UAF to be reported from nfc_alloc_send_skb(), but the
> > callers are responsible for managing the device access, and thus the
> > UAF being reported, as the callers (like nfc_llcp_send_ui_frame()) may
> > repeatedly call this function, and this function will repeatedly try
> > to get the same headroom and tailroom values.
> 
> I don't understand this sentence.
> 
> "This can cause ..., but ...". But starts another clause which should be
> in contradictory to previous one.

Sorry about that, I should have phrased it better.

> > Thus, put the nfc_dev access responsibility on the callers and accept
> > the headroom and tailroom values directly.
> 
> Is this a fix or improvement? If fix, is the UAF real? If so, you miss
> Fixes tag.

I intended to remove access to nfc_dev (accessing which causes UAF) inside
this function, as it is used only for fetching headroom and tailroom integral
values.

nfc_llcp_send_ui_frame() called this function in a do-while loop, so
I thought of extracting the values before the loop, so that in the next
patch where I used locking, I would have to lock only once*.

Since these are two units of changes, I separated them into two patches.

Though since the next patch is shit anyways, this patch is not needed.

Thanks,
Siddh
