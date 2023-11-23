Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0A57F663D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjKWS2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWS2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:28:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22158D41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:28:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F37C433C7;
        Thu, 23 Nov 2023 18:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700764122;
        bh=juVhUro89Fo8QDxH3ZtHvI4AUpp8fiX7rwhPxMpfQ9Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=D5cE95NOndOrBzIL+r2Cvf2QRI0uPZVCdp/5RDWgxw3/IlUmcIbIWomUE+mMEWums
         FBGq+f7G7N1kL2ZuobMQ3HouxWeB5C39J1bVeLYo/I0LAM3K5cE/KZLmFpl6G/k3p/
         5YJ2wMsV7VRaaASHNN/ShdWvp/1fLrlcD6L8x9/eUHm47Bvg6PEUy3Q016tEFvPV8j
         Ai7xasWcKLcO0h5e6hEHSCPN1pWo5q+8A1/N5vqIOU2qPYU1NXnv/qX5TSrjBUYKmS
         GS+z8pZOev9INpb7gnBi/jOCDR2NPsTxdWBNVjucri5PChFMyXln9ovrFqh0ULayY9
         fLRpBac4UPomA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 33D67CE0D0D; Thu, 23 Nov 2023 10:28:42 -0800 (PST)
Date:   Thu, 23 Nov 2023 10:28:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Provide a boot time parameter to enable lazy RCU
Message-ID: <29158f4d-f278-4344-9def-a10f728fa67a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231121205304.315146-1-qyousef@layalina.io>
 <811b2157-1009-4339-8ff2-0433512f3094@paulmck-laptop>
 <20231121214415.ovoskvbjarzpxi6e@airbuntu>
 <8ad4e628-7a88-490c-a54d-df09f851f189@paulmck-laptop>
 <20231121221556.vtpmboamgszbt3jf@airbuntu>
 <4ec83bf4-4c56-4f47-8473-151b57b80840@paulmck-laptop>
 <ZV-UEjyjjOHaRVPh@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV-UEjyjjOHaRVPh@localhost.localdomain>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 07:04:02PM +0100, Frederic Weisbecker wrote:
> Le Thu, Nov 23, 2023 at 09:42:12AM -0800, Paul E. McKenney a écrit :
> > On Tue, Nov 21, 2023 at 10:15:56PM +0000, Qais Yousef wrote:
> > > On 11/22/23 15:26, Paul E. McKenney wrote:
> > > 
> > > > > Either way; I'll follow what the crowd wants too :-)
> > > > 
> > > > Usually a wise choice.  ;-)
> > > > 
> > > > But I must defer to the people using it.
> > > 
> > > >From Android PoV I'd like to be able to boot with default disabled and allow
> > > people to opt-in. At least for the time being until we have confidence no one
> > > is caught with surprise if this caused unexpected problems.
> > > 
> > > In the future it might default to on once it gets wider usage and testing.
> > > 
> > > So having a new Kconfig to DEFAULT_OFF sounds good to me to enable a compile
> > > time switch to pick the default with a boot time to further control.
> > > 
> > > Which would be my plan for v2 unless I hear another suggestion in the coming
> > > week (where I hope people would have had a chance to look and think about it).
> > 
> > Sounds good to me!  Silence will be interpreted as assent.  ;-)
> 
> Silence sounds good to me :-)

This reply intentionally left content-free to preserve the silence.  ;-)

							Thanx, Paul
