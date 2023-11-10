Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B317A7E83F4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbjKJUcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbjKJUbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:31:32 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790CF3C6ED;
        Fri, 10 Nov 2023 08:19:13 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AAGJ26r116232;
        Fri, 10 Nov 2023 10:19:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699633142;
        bh=Xe1VAgDDx3SenUq0mNxbY7EhIA5lLQyuqqekh3OPQPo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=V+dmxbZu9MckJuICDqtqmRz7FG4UabBgEjTscAloKkHJt8khcrdK/FIbMNzoFEr3z
         nnS1mAvEMD8tK0j+OXz/NQdlZ9BBaUXoZ81jpyQq9wbq4yIesVXRh/lzVFzhw7Wrw1
         BAsD+dhEJd7TtVUhCZooHdQuZh6Ao6C+dSWFoPBA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AAGJ2fO085445
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Nov 2023 10:19:02 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 10:19:01 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 10:19:01 -0600
Received: from [10.249.135.225] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AAGIvmY007981;
        Fri, 10 Nov 2023 10:18:58 -0600
Message-ID: <0a49f195-0a06-1ffc-e4eb-3607d35a315f@ti.com>
Date:   Fri, 10 Nov 2023 21:48:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net v4] net: ti: icssg-prueth: Add missing icss_iep_put to
 error path
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Roger Quadros <rogerq@kernel.org>
References: <7a4e5c5b-e397-479b-b1cb-4b50da248f21@siemens.com>
Content-Language: en-US
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <7a4e5c5b-e397-479b-b1cb-4b50da248f21@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2023 9:43 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Analogously to prueth_remove, just also taking care for NULL'ing the
> iep pointers.
> 
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Fixes: 443a2367ba3c ("net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

> ---
> 
> Changes in v4:
>  - no functional ones
>  - added one original author in CC with new address (no address of
>    Grygorii available)
> 
> Changes in v3:
>  - consolidate cleanup logic further [Wojciech]
>  - make sure to NULL iep pointers
> 
> Changes in v2:
>  - add proper tags
> 
> This was lost from the TI SDK version while ripping out SR1.0 support - 
> which we are currently restoring for upstream.
> 
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 6c4b64227ac8..3abbeba26f1b 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -2105,10 +2105,7 @@ static int prueth_probe(struct platform_device *pdev)
>  	prueth->iep1 = icss_iep_get_idx(np, 1);
>  	if (IS_ERR(prueth->iep1)) {
>  		ret = dev_err_probe(dev, PTR_ERR(prueth->iep1), "iep1 get failed\n");
> -		icss_iep_put(prueth->iep0);
> -		prueth->iep0 = NULL;
> -		prueth->iep1 = NULL;
> -		goto free_pool;
> +		goto put_iep0;
>  	}
>  
>  	if (prueth->pdata.quirk_10m_link_issue) {
> @@ -2205,6 +2202,12 @@ static int prueth_probe(struct platform_device *pdev)
>  exit_iep:
>  	if (prueth->pdata.quirk_10m_link_issue)
>  		icss_iep_exit_fw(prueth->iep1);
> +	icss_iep_put(prueth->iep1);
> +
> +put_iep0:
> +	icss_iep_put(prueth->iep0);
> +	prueth->iep0 = NULL;
> +	prueth->iep1 = NULL;
>  
>  free_pool:
>  	gen_pool_free(prueth->sram_pool,

-- 
Thanks and Regards,
Md Danish Anwar
