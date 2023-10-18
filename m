Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472097CDB5E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjJRMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjJRMN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:13:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F10118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:13:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7127C433C7;
        Wed, 18 Oct 2023 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697631234;
        bh=9kgiB69q1oSigTcfJagfre6fl61MxiaXRrSluE83B8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAsS93gogehTCaSCV9273Zay7esIppToOsR0pXtmmx+r1h2dIQxTPAQvdVXvZHxDy
         a0k9bkHbbbT96LMcquv2NuRf7W2mL2vjUIEDm98CCYDtOfYrHib+/UIVRC1yFeIlSS
         c53CfLkNlOpfumQAZrrB7vhvZ8W3Lh50zrNzt2/QhMIhFG8ZDpMX3H5qrQnn+mn+WO
         eTAFG7eyUb10Kyw9doHxCHQOyWI5//4FLM7G/c8nYjJWipeR/1l5JPccNyEEk0Mifz
         miv6jzY/eb8qJU+ep72PP8+za+EKZbyx+oHbcIl9UxE2uNOMC2I1vpTummQMdpZeEw
         JwV89pfLfGpyA==
Date:   Wed, 18 Oct 2023 14:13:50 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] workqueue: Provide one lock class key per work_on_cpu()
 callsite
Message-ID: <ZS_L_pWMNVYLka-K@localhost.localdomain>
References: <20230924150702.9588-1-frederic@kernel.org>
 <ZS-rCIejToOlJcqm@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZS-rCIejToOlJcqm@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Oct 17, 2023 at 11:53:12PM -1000, Tejun Heo a écrit :
> On Sun, Sep 24, 2023 at 05:07:02PM +0200, Frederic Weisbecker wrote:
> > All callers of work_on_cpu() share the same lock class key for all the
> > functions queued. As a result the workqueue related locking scenario for
> > a function A may be spuriously accounted as an inversion against the
> > locking scenario of function B such as in the following model:
> > 
> > 	long A(void *arg)
> > 	{
> > 		mutex_lock(&mutex);
> > 		mutex_unlock(&mutex);
> > 	}
> > 
> > 	long B(void *arg)
> > 	{
> > 	}
> > 
> > 	void launchA(void)
> > 	{
> > 		work_on_cpu(0, A, NULL);
> > 	}
> > 
> > 	void launchB(void)
> > 	{
> > 		mutex_lock(&mutex);
> > 		work_on_cpu(1, B, NULL);
> > 		mutex_unlock(&mutex);
> > 	}
> > 
> > launchA and launchB running concurrently have no chance to deadlock.
> > However the above can be reported by lockdep as a possible locking
> > inversion because the works containing A() and B() are treated as
> > belonging to the same locking class.
> 
> Sorry about the delay. I missed this one. Applied to wq/for-6.7.

No problem, thanks a lot!

> 
> Thanks.
> 
> -- 
> tejun
