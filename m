Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5845D7CC86D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjJQQKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjJQQKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:10:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D419E;
        Tue, 17 Oct 2023 09:10:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DEEC433C7;
        Tue, 17 Oct 2023 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697559016;
        bh=QVFWCEda7RXc1Fn/309y5pkkYsNBM3szVrP2lYj+EPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vEOkJaybM7jummksAK+zXzsR+Fc05d9bzchW3jdf4Nk1TDXgJ1wOX0jhW5rTwMe/9
         FFwgXY4Nm9FUstXs+Pzz6tj0YIEj5n/FGFpgAz9p7qm7toZEnWk8btV8sRVQVst67T
         yFvS3dEAgLG0WANjJ3Smnrb3Qrt7yH9zs+IQeiFo=
Date:   Tue, 17 Oct 2023 18:10:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        ekangupt@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH v4 4/5] misc: fastrpc: Add support to save and restore
 interrupted
Message-ID: <2023101743-discern-plunging-83e4@gregkh>
References: <1697534799-5124-1-git-send-email-quic_ekangupt@quicinc.com>
 <1697534799-5124-5-git-send-email-quic_ekangupt@quicinc.com>
 <2023101739-heftiness-reproach-ef96@gregkh>
 <d800dcbf-83dc-4b0f-bdd3-fc0efb5dd771@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d800dcbf-83dc-4b0f-bdd3-fc0efb5dd771@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 08:36:28PM +0530, Ekansh Gupta wrote:
> 
> On 10/17/2023 6:50 PM, Greg KH wrote:
> > On Tue, Oct 17, 2023 at 02:56:38PM +0530, Ekansh Gupta wrote:
> > > For any remote call, driver sends a message to DSP using RPMSG
> > > framework. After message is sent, there is a wait on a completion
> > > object at driver which is completed when DSP response is received.
> > > 
> > > There is a possibility that a signal is received while waiting
> > > causing the wait function to return -ERESTARTSYS. In this case
> > > the context should be saved and it should get restored for the
> > > next invocation for the thread.
> > > 
> > > Adding changes to support saving and restoring of interrupted
> > > fastrpc contexts.
> > > 
> > > Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> > > Change-Id: Ia101acf7c1bf6018635536082bf7ea009093c948
> > > ---
> > > Changes in v2:
> > >    - Fixed missing definition
> > >    - Fixes compile time issue
> > You forgot to run checkpatch.pl :(
> 
> I did run checkpatch.pl and also tried compilation test. checkpatch.pl is
> suggesting 0 errors, 0 warning and compilation also worked without any
> errors. I might have checked on last week's base as there were no changes in
> these files. I'll check the patches with latest version and update again if
> any errors/warnings are observed. Thanks for reviewing the patch. -ekansh

The "Change-Id:" should not be there, and I thought checkpatch would
catch that.  If not, no big deal, you should have :)

