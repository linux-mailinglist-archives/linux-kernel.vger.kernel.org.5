Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9F776E533
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjHCKFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjHCKF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8179130F9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691057080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=McoNTIMuK5zMDVano2/oBxpTU9klATcskOJG6KujI/k=;
        b=auVIM0oQYqYNfA8GCWjyUqutbHxlT1uvERRxy9bD6fYHlNmI1M246L3u0LcfipOEjwRzR9
        OxwX6wKS1ldWH2E+p8wcX/Un5gvDpzT6vqGrMN7276CYWzROIlV5vWoy6AUNOMBhVFQ3CR
        8GnlHaO7Ei39OzZeIT7euZghaGDXEoA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-KsCoURf7PvCzm9ni6wcQjQ-1; Thu, 03 Aug 2023 06:04:37 -0400
X-MC-Unique: KsCoURf7PvCzm9ni6wcQjQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40fed04ea2aso867401cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057077; x=1691661877;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=McoNTIMuK5zMDVano2/oBxpTU9klATcskOJG6KujI/k=;
        b=WeLaMbROQqFOBUTEuMCLPgPy5ueCQiYNXKDeSgZHrOhjF6ZSZ5riXesIWcA0QwLJit
         5LpnjZ6vQuH+pIxoUkUdoKz2dSE69yt3AOUWyRJrm56j1Dt6z+q0e8zs3Br5a69jB/Yr
         wjpXNejrhvcvfFLQhTKnxMU+c0AsAfZ1U8vZKj9C7zECITWHHAaQ2A32Yydq3MHA9QO6
         Amk8a+Kh3RhaSp8JgIAyEA8Z1/otzdgn66YkrOgeCJ6cXtaz+rV+9S84Qza0bAjUSnLX
         sotaVTBBnXwOWLsu03+AXoSvmRUs06hbzboWn+pGcudleXoV9GE/SkcBw6yFEzCo8521
         owdw==
X-Gm-Message-State: ABy/qLbOPHfsgRCsepHzCwhCxfhZtHGfayBsSfwM1n+JMXmsvL6fajuZ
        ij8YMtid4E/cYBPZJxbaQsXbsJcR3Pd3dhF3pI+UBZhi0ppKVUJPaaLKQEKRrNqvOlhcCD/F7dL
        2ysDAXXxuxh8uN6rsQhK39ZLP
X-Received: by 2002:a05:622a:1aa5:b0:40c:8ba5:33e0 with SMTP id s37-20020a05622a1aa500b0040c8ba533e0mr19691162qtc.3.1691057077036;
        Thu, 03 Aug 2023 03:04:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGgowyf6XhafmTFhwd4kIxj/a9sk7muDM9IwOhYJ5Cfu4506FYfrrjqry1ZVBPlzqgd92Dqag==
X-Received: by 2002:a05:622a:1aa5:b0:40c:8ba5:33e0 with SMTP id s37-20020a05622a1aa500b0040c8ba533e0mr19691138qtc.3.1691057076756;
        Thu, 03 Aug 2023 03:04:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-226.dyn.eolo.it. [146.241.226.226])
        by smtp.gmail.com with ESMTPSA id q5-20020ac87345000000b004069782c943sm6061394qtp.40.2023.08.03.03.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:04:36 -0700 (PDT)
Message-ID: <c90e655ed51d8a0e21e529573ebb46040de91663.camel@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH v3 net-next 00/10] Improve the taprio
 qdisc's relationship with its children
From:   Paolo Abeni <pabeni@redhat.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc:     Jiri Pirko <jiri@resnulli.us>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        intel-wired-lan@lists.osuosl.org,
        Maxim Georgiev <glipus@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Thu, 03 Aug 2023 12:04:32 +0200
In-Reply-To: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2023-08-01 at 21:24 +0300, Vladimir Oltean wrote:
> Changes in v3:
> Fix ptp_mock compilation as module, fix small mistakes in selftests.
>=20
> Changes in v2:
> It was requested to add test cases for the taprio software and offload mo=
des.
> Those are patches 08 and 09.
>=20
> That implies adding taprio offload support to netdevsim, which is patch 0=
7.
>=20
> In turn, that implies adding a PHC driver for netdevsim, which is patch 0=
6.
>=20
> v1 at:
> https://lore.kernel.org/lkml/20230531173928.1942027-1-vladimir.oltean@nxp=
.com/
>=20
> Original message:
>=20
> Prompted by Vinicius' request to consolidate some child Qdisc
> dereferences in taprio:
> https://lore.kernel.org/netdev/87edmxv7x2.fsf@intel.com/
>=20
> I remembered that I had left some unfinished work in this Qdisc, namely
> commit af7b29b1deaa ("Revert "net/sched: taprio: make qdisc_leaf() see
> the per-netdev-queue pfifo child qdiscs"").
>=20
> This patch set represents another stab at, essentially, what's in the
> title. Not only does taprio not properly detect when it's grafted as a
> non-root qdisc, but it also returns incorrect per-class stats.
> Eventually, Vinicius' request is addressed too, although in a different
> form than the one he requested (which was purely cosmetic).
>=20
> Review from people more experienced with Qdiscs than me would be
> appreciated. I tried my best to explain what I consider to be problems.
> I am deliberately targeting net-next because the changes are too
> invasive for net - they were reverted from stable once already.

The series LGTM, modulo the minor comments from Kurt on patch 6/10. I
agree they can be handled with follow-up patches.

Keeping it a little longer on PW: it would be great if someone from the
tc crew could have a look!

Thanks!

Paolo

