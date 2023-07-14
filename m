Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9024D7534E9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjGNISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjGNISS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:18:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420F31B6;
        Fri, 14 Jul 2023 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689322696; x=1720858696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O/X2f8LTxeBpseEWtQTCQinmCmN6v3Zs9Ep5/+MhYq4=;
  b=XOaYrlPdqV5d2WMhEualoMjFswG+FnXYxyagjXNlbqgU1TLzQwITpagf
   2tUy4zVWo/sloWvMkYtarlLfF2wbKEO3g6HMFy7xQiB4PTILtLNZYobYL
   Poci9KiAd4kjwE1XYEd6G3YHm0mzVDXh1y8Mh/WIwJoLjE8X1V62D34iY
   QQjcHOd5omnZH41NqXygX0/YuOBgcnpMEt3+hsAWi48zi/D0qQ0cZD7Qx
   t3yKrsRdPtRhVFqXbCIvoH26n7EZf61j8Pdzb5mD4nUe7iWOuN2AZCzWu
   ztB9D/no4bU+/Jv3szHQucsY/i/vhioCua9MBM8GJ2c4K+T+yYiFaQfaF
   A==;
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="161331392"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2023 01:18:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 14 Jul 2023 01:18:14 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 14 Jul 2023 01:18:14 -0700
Date:   Fri, 14 Jul 2023 10:18:14 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Minjie Du <duminjie@vivo.com>
CC:     <dkirjanov@suse.de>,
        "maintainer:MICROCHIP LAN966X ETHERNET DRIVER" 
        <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "open list:MICROCHIP LAN966X ETHERNET DRIVER" 
        <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
        <opensource.kernel@vivo.com>
Subject: Re: [PATCH v2] net: lan966x: fix parameter check in two functions
Message-ID: <20230714081814.3jltswaui6gbgkhc@soft-dev3-1>
References: <20230714012220.891-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20230714012220.891-1-duminjie@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/14/2023 09:22, Minjie Du wrote:

Hi Minjie,

> 
> Make IS_ERR_OR_NULL() judge the vcap_get_rule() function return.
> in lan966x_ptp_add_trap() and lan966x_ptp_del_trap().
> 
> Fixes: 72df3489fb10 ("net: lan966x: Add ptp trap rules")
> Signed-off-by: Minjie Du <duminjie@vivo.com>

You forgot to set the target tree in the subject. You can do that when
you create the patch using the command:
git format-patch ... --subject-prefix "PATCH net" ...

Other than that, it looks OK:
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> index 266a21a2d..59dd14247 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> @@ -59,7 +59,7 @@ static int lan966x_ptp_add_trap(struct lan966x_port *port,
>         int err;
> 
>         vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
> -       if (vrule) {
> +       if (!IS_ERR_OR_NULL(vrule)) {
>                 u32 value, mask;
> 
>                 /* Just modify the ingress port mask and exit */
> @@ -106,7 +106,7 @@ static int lan966x_ptp_del_trap(struct lan966x_port *port,
>         int err;
> 
>         vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
> -       if (!vrule)
> +       if (IS_ERR_OR_NULL(vrule))
>                 return -EEXIST;
> 
>         vcap_rule_get_key_u32(vrule, VCAP_KF_IF_IGR_PORT_MASK, &value, &mask);
> --
> 2.39.0
> 
> 

-- 
/Horatiu
