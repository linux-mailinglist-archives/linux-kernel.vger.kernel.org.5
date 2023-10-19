Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121D47CF577
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjJSKgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjJSKg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB227119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697711739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpEQnQGcZBGxUIaYWGMcy9n7tEk18RvnwU74mxj0B5I=;
        b=f23Aw6+W8pZ6AyzNWTAELcLZGykBZjLOlqdjaVqLy1ulAtZyRhmK4P2TkyGe0WRFmhOT7R
        IT6qgL/CCJQ8RXBydg3vepTvjRoUQnAO0vAxFq98deuGNg7y//Pq446v6Fj1kq3MoqD177
        eMQaMYVMUmbJRsEZ6Q+9V3Q9c7Bl6qc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-0yycs9tSMgWcPG2CACMBKw-1; Thu, 19 Oct 2023 06:35:33 -0400
X-MC-Unique: 0yycs9tSMgWcPG2CACMBKw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-534838150afso895659a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697711732; x=1698316532;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpEQnQGcZBGxUIaYWGMcy9n7tEk18RvnwU74mxj0B5I=;
        b=evkLfygnWPsCbsfbfF0VvHYJF3QKjWk1ZFUcX54Pwf0+TtH4dInPt2J/dNmEXFOm05
         sOLukSWquXKLuLxrZWixITNBeFBTqgHWQn7S6+FqtYi0R8CgL03D/jvqXzOlspZpCG+r
         S4IaTOicues6iD0Hkth5zfQzkL+BERQJbVxADvvO0YsopMvYJyxZy5LM5zbS0xtyJHOx
         FCWBgKUWQhngTTWWt0rLuVvD7jsF6oAh1mpNiD5MXYEgkR36vB53MEwKBvLCi0sGf2K5
         KFXHyJBorEyP20MNIY0zmUDu0tW18Csw6GtIA5B2OQjD7VHFBsQWnJ620/tG40q33iqN
         842A==
X-Gm-Message-State: AOJu0YwjFu9EeaSuMzauMxDXNaLjMamxQq/PVq4+9VXy8sCGPvQNkD07
        00zkvkfH6z1X68urqNen4ti9BTuHfCf9GDThCv2YcwUyslnYQEFjJ6hTmfHrLNQ1MwIo/u+eXNH
        yWPO/m/HliQBYqZlyPwA8JyIR
X-Received: by 2002:a17:907:9708:b0:9b2:bf2d:6b66 with SMTP id jg8-20020a170907970800b009b2bf2d6b66mr1550678ejc.7.1697711732631;
        Thu, 19 Oct 2023 03:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+uzuwow9Q+Q1sZxE0P8RlP/h4HgXhv3+NSLWInRWptB+qhUaWBzKH9pRXhnnfPJAbD+He1g==
X-Received: by 2002:a17:907:9708:b0:9b2:bf2d:6b66 with SMTP id jg8-20020a170907970800b009b2bf2d6b66mr1550657ejc.7.1697711732210;
        Thu, 19 Oct 2023 03:35:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-142.dyn.eolo.it. [146.241.237.142])
        by smtp.gmail.com with ESMTPSA id gz21-20020a170906f2d500b009ae0042e48bsm3330617ejb.5.2023.10.19.03.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:35:31 -0700 (PDT)
Message-ID: <bca0aca50914367fffccf33b2f2ac880808d6cd9.camel@redhat.com>
Subject: Re: [PATCH net-next v2 1/1] taprio: Add boundary check for
 sched-entry values
From:   Paolo Abeni <pabeni@redhat.com>
To:     Gerhard Engleder <gerhard@engleder-embedded.com>,
        Lai Peter Jun Ann <jun.ann.lai@intel.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 Oct 2023 12:35:30 +0200
In-Reply-To: <27912b49-eb1a-4100-a260-03299e8efdd4@engleder-embedded.com>
References: <1697599707-3546-1-git-send-email-jun.ann.lai@intel.com>
         <27912b49-eb1a-4100-a260-03299e8efdd4@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-18 at 19:56 +0200, Gerhard Engleder wrote:
> On 18.10.23 05:28, Lai Peter Jun Ann wrote:
> > Adds boundary checks for the gatemask provided against the number of
> > traffic class defined for each sched-entry.
> >=20
> > Without this check, the user would not know that the gatemask provided =
is
> > invalid and the driver has already truncated the gatemask provided to
> > match the number of traffic class defined.
> >=20
> > Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@int=
el.com>
> > Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> > Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> > ---
> >   net/sched/sch_taprio.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >=20
> > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > index 1cb5e41..44b9e21 100644
> > --- a/net/sched/sch_taprio.c
> > +++ b/net/sched/sch_taprio.c
> > @@ -102,6 +102,7 @@ struct taprio_sched {
> >   	u32 max_sdu[TC_MAX_QUEUE]; /* save info from the user */
> >   	u32 fp[TC_QOPT_MAX_QUEUE]; /* only for dump and offloading */
> >   	u32 txtime_delay;
> > +	u8 num_tc;
> >   };
> >  =20
> >   struct __tc_taprio_qopt_offload {
> > @@ -1063,6 +1064,11 @@ static int fill_sched_entry(struct taprio_sched =
*q, struct nlattr **tb,
> >   		return -EINVAL;
> >   	}
> >  =20
> > +	if (entry->gate_mask >=3D q->num_tc) {
>=20
> As far as I know within gate_mask every bit represents a traffic class.
> So for 3 traffic classes at gate_mask of 0x7 is valid but this check
> fails with 0x7 >=3D 3.

Additionally whatever check we put in place previously just ignored by
the existing code, could break the existing user-space: we can't accept
such change.=20

Cheers,

Paolo

