Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1D07CFDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbjJSPRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjJSPRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:17:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7088B11B;
        Thu, 19 Oct 2023 08:17:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E51C433C7;
        Thu, 19 Oct 2023 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697728659;
        bh=WtVNBWC5iNjbnScpjiJDxp8GdsgsTgsH5bVGO2dnDFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueOCtb8TLybx9AXSOcBSm2CkxjqD3rXqlLe1hBgQL4guFYt9A9ld77Tg2HjbC6I2O
         6GlFAo/ZlGKnRsw3N3mRy0cvXRyzLjTlWP+VGrLngQMb3movYXiFNSxTSOzAU9U2mG
         UoHaq0cADAyCel5zgFycAu8fqXLvYg0u/zeKKfgyF3JPWAGx7zN2CFhWPH1s2snv8M
         X5cRVu/cCbZa5jN/INltP35xMFxOzRNYAFRbj0r1TWHKmkq6eHkRLkvRCg8ZVp7jCJ
         2jTmgBsPOMXsx4+ot11p7+juPto3ClaY9SxL/ui8wZ8V0HQf3MO7wDKgU0q9AiQ//8
         Fb/KK4JAtRLfg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qtUmL-0005Sf-2m;
        Thu, 19 Oct 2023 17:17:42 +0200
Date:   Thu, 19 Oct 2023 17:17:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: ath11k: fix temperature event locking
Message-ID: <ZTFIlS79DclOOjrS@hovoldconsulting.com>
References: <20231019104211.13769-1-johan+linaro@kernel.org>
 <20231019104211.13769-2-johan+linaro@kernel.org>
 <4233c8af-5911-40bf-b5ba-dd0a63863a45@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4233c8af-5911-40bf-b5ba-dd0a63863a45@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:04:55AM -0700, Jeff Johnson wrote:
> On 10/19/2023 3:42 AM, Johan Hovold wrote:
> > The ath11k active pdevs are protected by RCU but the temperature event
> > handling code calling ath11k_mac_get_ar_by_pdev_id() was not marked as a
> > read-side critical section as reported by RCU lockdep:
> 
> How do I enable this? Just enable CONFIG_PROVE_RCU?

Yeah, via CONFIG_PROVE_LOCKING.

> Of course I'd also need to exercise the code path...

Right, this one I hit when reading out the sensor temperature (e.g.
using lm_sensors).
 
> > +	rcu_read_lock();
> > +
> >   	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
> >   	if (!ar) {
> >   		ath11k_warn(ab, "invalid pdev id in pdev temperature ev %d", ev->pdev_id);
> 
> aren't you missing an unlock() in this error path?
> 
> perhaps have a goto cleanup that does both the unlock() and the kfree()?

Bah, I am, thanks for catching that.

Spent too much time on scanning for further instances that I didn't
check the first one properly. Sorry about that. Will send a v2.

Johan
