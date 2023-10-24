Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14447D55A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjJXPTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjJXPSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:18:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1246919AB;
        Tue, 24 Oct 2023 08:17:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63D2C433CB;
        Tue, 24 Oct 2023 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698160659;
        bh=Yc5CJPTtSMwymg05TTypHEKQD0X0q++YptYmz8lGZxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Po9/XiE+0wrYuCxp539fhXU/t3kxxUsnbvYHpVX4cV9eLm3jfjmlx/7jlGdrWVBu8
         0dpGrXF2+CLoF1C0YU0ELgszjrRXf0IOZDBT70I8hDQL5arhc8/k5uqpjETmpHyh4G
         Biczvhq7i0Puygvw3RrjxILTmT6DFD4L9wZNZmtvV/zzxW5Of33TuNZBuaqhxTjbGc
         MHRPkCGgb7zFfkf7XTA5PXG/pHZE6m6vNjShVGWCk3FceEe6fZq4NWy0lUKR+6jBw+
         mP9NN+RU+TbQRZ8q5Hwm9TCNkRyNJdYdlnCM1AKN8SzKCMas/i4CJzxDOVgJJwIDvM
         K9DlM5NbeHi6g==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvJAK-0003r8-1q;
        Tue, 24 Oct 2023 17:17:57 +0200
Date:   Tue, 24 Oct 2023 17:17:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] wifi: ath11k: fix event locking
Message-ID: <ZTfgJCBxsNv3bVjv@hovoldconsulting.com>
References: <20231019153115.26401-1-johan+linaro@kernel.org>
 <87o7goxget.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7goxget.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 05:07:38PM +0300, Kalle Valo wrote:
> Johan Hovold <johan+linaro@kernel.org> writes:
> 
> > RCU lockdep reported suspicious RCU usage when accessing the temperature
> > sensor. Inspection revealed that the DFS radar event code was also
> > missing the required RCU read-side critical section marking.
> >
> > Johan
> >
> >
> > Changes in v2
> >  - add the missing rcu_read_unlock() to an
> >    ath11k_wmi_pdev_temperature_event() error path as noticed by Jeff
> >
> >
> > Johan Hovold (2):
> >   wifi: ath11k: fix temperature event locking
> >   wifi: ath11k: fix dfs radar event locking
> 
> Thanks for the fixes. I really like using lockdep_assert_held() to
> document if a function requires some lock held, is there anything
> similar for RCU?

Not really, but the checking is instead built into the primitives like
rcu_dereference() and enabled whenever CONFIG_PROVE_RCU is set.

For some special cases, we have open-coded checks like:

	RCU_LOCKDEP_WARN(!rcu_read_lock_held());

which similarly depend on CONFIG_PROVE_RCU or simply

	WARN_ON_ONCE(!rcu_read_lock_held());

Johan
