Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADD27D6780
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjJYJvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYJvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:51:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C70DD;
        Wed, 25 Oct 2023 02:51:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ADBC433C7;
        Wed, 25 Oct 2023 09:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698227473;
        bh=+cg3kYM3oFry35hZbmbwSVjd6ek+Za/QIdrk5JlXVCU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Mk3aBPSYzxfaNtQwgFmWCAiO3PKRxQWVvwar4NEUMMiOvsIundUsqhpzRFFMObBCE
         QveXtgBd9HCA98TLqFTA7yovLjoI21iZM1b2zsZT+w7MRzWAckSLuIKE2YobbE61dQ
         sgLdpJ/XgcIOmVN79MziCxoVSJzNyhWmXslfB81mka1hPexK5GDEhlcoSjoBwK0fto
         bW9Wzd1ZHIMD7kMd60aPMQtGNiYylkYtgeclMtVyBvZnyl1bTaNtztUOlC3YFUNyfZ
         2+dIJhrxa0fr8p8lwqkv2YcQ8y8axKaoishIr0bOR+6khcx8rQgNlfypsgPtQ8fVrF
         QAAdapnSoULUA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] wifi: ath11k: fix temperature event locking
References: <20231019153115.26401-1-johan+linaro@kernel.org>
        <20231019153115.26401-2-johan+linaro@kernel.org>
        <87sf60xgs8.fsf@kernel.org> <ZTfUswqVkAgJvnye@hovoldconsulting.com>
Date:   Wed, 25 Oct 2023 12:51:10 +0300
In-Reply-To: <ZTfUswqVkAgJvnye@hovoldconsulting.com> (Johan Hovold's message
        of "Tue, 24 Oct 2023 16:29:07 +0200")
Message-ID: <87bkcnxc6p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

> On Tue, Oct 24, 2023 at 04:59:35PM +0300, Kalle Valo wrote:
>> Johan Hovold <johan+linaro@kernel.org> writes:
>> 
>> > The ath11k active pdevs are protected by RCU but the temperature event
>> > handling code calling ath11k_mac_get_ar_by_pdev_id() was not marked as a
>> > read-side critical section as reported by RCU lockdep:
>
>> On what hardware and firmware version did you test this? As there's so
>> many different combos we use Tested-on tag to provide that information
>> in the commit message:
>> 
>> https://wireless.wiki.kernel.org/en/users/drivers/ath11k/submittingpatches#tested-on_tag
>> 
>> I can add that if you let me know what you used.
>
> I hit this on the Lenovo Thinkpad X13s and I guess the tag should be:
>
> Tested-on: QCNFA765 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

From ath11k point of view QCNFA765 is WCN6855 so I used this one:

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

> Note that I've only been able to test the ath11k fixes (not the
> corresponding ath12k) and I only tested this particular patch fully

Thanks, I added Tested-on to this patch 1 and for the rest I added
"compile tested only".

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
