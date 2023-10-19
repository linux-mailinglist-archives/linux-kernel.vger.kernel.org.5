Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7EE7CF93B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345694AbjJSMmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345495AbjJSMmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:42:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A912A4;
        Thu, 19 Oct 2023 05:42:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9adb9fa7200so162716066b.0;
        Thu, 19 Oct 2023 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697719325; x=1698324125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HbETqJO7gr5G309pfc0V+D4Oi3AQtNMOXUVI2EJql7Y=;
        b=a7X2aQSRu5NcrOL4cn7ghK5Kb8B7uDshis1OU7/CSyumlzk2wUGhmetuib14Vkbjkr
         Je4I6/5b0A7+5f2mj9fbFNioFhfujZ15jhivPp+VKVtUGaKmZamCdQNqHkJ9BLRJLPYs
         DY7V9dxleOSsJy/XvaiwwBo6cBJjYHVz7qOG+1QK76fVfnWBsSZ4kd40yPtoodSslcSA
         42W7JzVtt4enf6HKAT2oY99zbpVU7KyJn3PvLr3kFIIN/phV3VJBSlIhk0mQzI62WSTl
         YmIa+H7GioLdcGvH6/1BZLGXYx36gi8gcCj9Fe3jODOmrbyyST6VAbnvQN0Cpf7R1j7a
         uTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697719325; x=1698324125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbETqJO7gr5G309pfc0V+D4Oi3AQtNMOXUVI2EJql7Y=;
        b=fMwH+Z1Lw64JxKrafH0R6JKMOuEfv1VKQxxQLGmqNJujbpIgPELbND2UP8B5q7jKZv
         3rfaO0zwGeen2N97WrzdE9Izg8cveDEZd8N7oFvMz5mg4dPOCBcX5FpsN702x8bW/v0i
         stGHfzWq5eYFmQiLwHtuGcpnezxp6F3vQKVITGNdmdm1lx4KeMdcZSwh0HlAt8+5PN22
         HAEr8aw3zWlOfSaOVENmGA5H6Ings4IQvzP9FDxP6AYsZRwyUAbyRRNl/Mp2zu0RskxI
         xYXhQdTOhctaA0pJuzWqB9VL7Mns2U8E+aMP3DsSaSQJFdRNAo+CAZleFwpPNiKvA4rv
         3Hng==
X-Gm-Message-State: AOJu0Yy9U1Eyg81gk94tD31OQarWM64HMnFxzicuKn9hfl1fF6H7o0ND
        mnIZ8LRBGHBgLpXunCRBSEU=
X-Google-Smtp-Source: AGHT+IEUbOe0aJdiDWwgZ49Mqf0FMEQpzhd5DOtuFo/cZUxDF9/XU8HxW5TldQf5jZL60tohfvemyw==
X-Received: by 2002:a17:907:9490:b0:9ae:5a56:be32 with SMTP id dm16-20020a170907949000b009ae5a56be32mr1688089ejc.38.1697719325237;
        Thu, 19 Oct 2023 05:42:05 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id cd9-20020a170906b34900b009a193a5acffsm3486374ejb.121.2023.10.19.05.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:42:04 -0700 (PDT)
Date:   Thu, 19 Oct 2023 15:42:02 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Gerhard Engleder <gerhard@engleder-embedded.com>,
        Lai Peter Jun Ann <jun.ann.lai@intel.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] taprio: Add boundary check for
 sched-entry values
Message-ID: <20231019124202.fldo2cc5s6w4hrxz@skbuf>
References: <1697599707-3546-1-git-send-email-jun.ann.lai@intel.com>
 <27912b49-eb1a-4100-a260-03299e8efdd4@engleder-embedded.com>
 <bca0aca50914367fffccf33b2f2ac880808d6cd9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bca0aca50914367fffccf33b2f2ac880808d6cd9.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:35:30PM +0200, Paolo Abeni wrote:
> On Wed, 2023-10-18 at 19:56 +0200, Gerhard Engleder wrote:
> > On 18.10.23 05:28, Lai Peter Jun Ann wrote:
> > > Adds boundary checks for the gatemask provided against the number of
> > > traffic class defined for each sched-entry.
> > > 
> > > Without this check, the user would not know that the gatemask provided is
> > > invalid and the driver has already truncated the gatemask provided to
> > > match the number of traffic class defined.
> > > 
> > > Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> > > Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> > > Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> > > ---
> > >   net/sched/sch_taprio.c | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > > index 1cb5e41..44b9e21 100644
> > > --- a/net/sched/sch_taprio.c
> > > +++ b/net/sched/sch_taprio.c
> > > @@ -102,6 +102,7 @@ struct taprio_sched {
> > >   	u32 max_sdu[TC_MAX_QUEUE]; /* save info from the user */
> > >   	u32 fp[TC_QOPT_MAX_QUEUE]; /* only for dump and offloading */
> > >   	u32 txtime_delay;
> > > +	u8 num_tc;

To the patch: I would oppose introducing an "u8 num_tc" to struct
taprio_sched for one purpose only. It is a duplication of
netdev->num_tc, the only problem is that it hasn't yet been set, which
can be solved with a bit of code reorganization.

> > >   };
> > >   
> > >   struct __tc_taprio_qopt_offload {
> > > @@ -1063,6 +1064,11 @@ static int fill_sched_entry(struct taprio_sched *q, struct nlattr **tb,
> > >   		return -EINVAL;
> > >   	}
> > >   
> > > +	if (entry->gate_mask >= q->num_tc) {
> > 
> > As far as I know within gate_mask every bit represents a traffic class.
> > So for 3 traffic classes at gate_mask of 0x7 is valid but this check
> > fails with 0x7 >= 3.
> 
> Additionally whatever check we put in place previously just ignored by
> the existing code, could break the existing user-space: we can't accept
> such change. 

I agree, and I would oppose erroring out.

I used to have this patch which simply masks off the excess bits,
calling netdev_warn() - which can be transformed into a warning netlink
extack - instead.
https://patchwork.kernel.org/project/netdevbpf/patch/20230130173145.475943-15-vladimir.oltean@nxp.com/

I didn't have a strong motivation for the patch, and I dropped it.
If Lai Peter Jun Ann can come with the motivation, we can go with that
approach.
