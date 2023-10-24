Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A697D5412
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjJXObx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343801AbjJXO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:28:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6EA10D1;
        Tue, 24 Oct 2023 07:28:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAC1C433C8;
        Tue, 24 Oct 2023 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698157730;
        bh=ypIMNYS6FyQIe4ePxJ+5oz5tdfmsVd2FnFFM7K0THyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlDwkr7Eyhll2twIrEyMEwBLTavG1kyr+CWEQ2B2ZqyPbnY/TbuAeNOX3Ll1wDHBl
         TygyF3lpuqVhzRJGWhol+qx5QNalxy+raSfqOnt44i4R4aRRR92f3JJsDk5tXd98a5
         V8Pnks0xHYH7gu6tpSZEWMGOyyeZDbbDAIKa7QXbHFRYvR4WM4n/TEqMZLAo6DgWJ5
         bD5ZsFfKUqZyYBJhCL47B7ZZUz+lr6tcsxwQ/j+jLnZ403pwZ7sRplkpgp+sPaSBaj
         IsY1wg7aqo9Fek4rcJbdICYNb2zArlG7oZVNQwBcJIakMomr1DkO4eysy7nFcHjD2l
         lVnY0egCFg92Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvIP5-0003aY-08;
        Tue, 24 Oct 2023 16:29:07 +0200
Date:   Tue, 24 Oct 2023 16:29:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] wifi: ath11k: fix temperature event locking
Message-ID: <ZTfUswqVkAgJvnye@hovoldconsulting.com>
References: <20231019153115.26401-1-johan+linaro@kernel.org>
 <20231019153115.26401-2-johan+linaro@kernel.org>
 <87sf60xgs8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf60xgs8.fsf@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 04:59:35PM +0300, Kalle Valo wrote:
> Johan Hovold <johan+linaro@kernel.org> writes:
> 
> > The ath11k active pdevs are protected by RCU but the temperature event
> > handling code calling ath11k_mac_get_ar_by_pdev_id() was not marked as a
> > read-side critical section as reported by RCU lockdep:

> On what hardware and firmware version did you test this? As there's so
> many different combos we use Tested-on tag to provide that information
> in the commit message:
> 
> https://wireless.wiki.kernel.org/en/users/drivers/ath11k/submittingpatches#tested-on_tag
> 
> I can add that if you let me know what you used.

I hit this on the Lenovo Thinkpad X13s and I guess the tag should be:

Tested-on: QCNFA765 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Note that I've only been able to test the ath11k fixes (not the
corresponding ath12k) and I only tested this particular patch fully
(e.g. since I didn't trigger any radar events).

Johan
