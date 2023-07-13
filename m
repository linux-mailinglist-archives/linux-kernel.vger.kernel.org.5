Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DF875161F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjGMCQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjGMCQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:16:51 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6536F2117
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 19:16:48 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-767582c6c72so21145285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 19:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689214607; x=1691806607;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLRUl5AEz4xfBRj0i8SQThC0f/OuUsY40TC9Xg4abaA=;
        b=hkYYZxV/H6WPwxqD8d9vTMIlQVEbUwmHDwP456khtAclR9f++sJEJVcmMm6doJpAaQ
         ogqF5NtL1hNnF/kt+Sxly7CdccRu+h9u+yM79dJXBa0/Judo/EX7b42d6IVleLt5scnY
         FhIej7EBkK0LF8qZ58Pz9eSUj8zfP82glH7zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689214607; x=1691806607;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLRUl5AEz4xfBRj0i8SQThC0f/OuUsY40TC9Xg4abaA=;
        b=WYVPDXqBBqydYM8B24mM39KhIt1UAMAZwuuLvjZb1b3fA48P01AX6k/xmel+1o1JtZ
         5epGwL5mKDHEtv4IXIsYSWGuA789nC43IrVrCkq93zIqFZA2C/DW/27KfilJIVrSfprd
         EcWIhNk223j63zHaStul0ba/Shk54KMJILPVXw36TKceBIkwWoFLitu/OwmW2q5C59ay
         ysaAZRs3JONLAQJ3gdGRySl4K10+K6Q9g4cnMNnX0vKeUQaQvS65pKSII55BTHvM5YIu
         YaQwTFZZUC7oltn3mj6kttGMzfPfkyxng+i9fZcJ+RZtqnhjlfePpmqTwYE5ySQTgtKG
         Pfng==
X-Gm-Message-State: ABy/qLY8Xd+3spjnJ8RoIx+UbWRigOqs1LQWLY0eTGL3M324rFlcH9JP
        heomvPOpgJaet1obQpnDAaQVQQ==
X-Google-Smtp-Source: APBJJlEHYFXDl9ioZHBQvN/8vyjr4+5VOyHSJ2h1343YSyKCNTY2VRSulWSAIsk6+5Jj5IBsNS3DvA==
X-Received: by 2002:ac8:7d4c:0:b0:401:e1e7:a2a4 with SMTP id h12-20020ac87d4c000000b00401e1e7a2a4mr404180qtb.35.1689214607496;
        Wed, 12 Jul 2023 19:16:47 -0700 (PDT)
Received: from smtpclient.apple ([192.145.116.85])
        by smtp.gmail.com with ESMTPSA id t4-20020ac85304000000b00401f7f23ab6sm2713019qtn.85.2023.07.12.19.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 19:16:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
Date:   Wed, 12 Jul 2023 22:16:34 -0400
Message-Id: <5DA6D217-8847-4760-9C23-CB1B26B5CC2B@joelfernandes.org>
References: <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
Cc:     Sandeep Dhavale <dhavale@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2023, at 10:02 PM, Gao Xiang <hsiangkao@linux.alibaba.com> wrot=
e:
>=20
> =EF=BB=BF
>=20
>> On 2023/7/13 08:32, Joel Fernandes wrote:
>> On Wed, Jul 12, 2023 at 02:20:56PM -0700, Sandeep Dhavale wrote:
>> [..]
>>>> As such this patch looks correct to me, one thing I noticed is that
>>>> you can check rcu_is_watching() like the lockdep-enabled code does.
>>>> That will tell you also if a reader-section is possible because in
>>>> extended-quiescent-states, RCU readers should be non-existent or
>>>> that's a bug.
>>>>=20
>>> Please correct me if I am wrong, reading from the comment in
>>> kernel/rcu/update.c rcu_read_lock_held_common()
>>> ..
>>>   * The reason for this is that RCU ignores CPUs that are
>>>  * in such a section, considering these as in extended quiescent state,
>>>  * so such a CPU is effectively never in an RCU read-side critical secti=
on
>>>  * regardless of what RCU primitives it invokes.
>>>=20
>>> It seems rcu will treat this as lock not held rather than a fact that
>>> lock is not held. Is my understanding correct?
>> If RCU treats it as a lock not held, that is a fact for RCU ;-). Maybe yo=
u
>> mean it is not a fact for erofs?
>=20
> I'm not sure if I get what you mean, EROFS doesn't take any RCU read lock

We are discussing the case 3 you mentioned below.

> here:
>=20
> z_erofs_decompressqueue_endio() is actually a "bio->bi_end_io", previously=

> which can be called under two scenarios:
>=20
> 1) under softirq context, which is actually part of device I/O compleltion=
;
>=20
> 2) under threaded context, like what dm-verity or likewise calls.
>=20
> But EROFS needs to decompress in a threaded context anyway, so we trigger
> a workqueue to resolve the case 1).
>=20
>=20
> Recently, someone reported there could be some case 3) [I think it was
> introduced recently but I have no time to dig into it]:
>=20
> case 3: under RCU read lock context, which is shown by this:
> https://lore.kernel.org/r/4a8254eb-ac39-1e19-3d82-417d3a7b9f94@linux.aliba=
ba.com/T/#u
>=20
> and such RCU read lock is taken in __blk_mq_run_dispatch_ops().
>=20
> But as the commit shown, we only need to trigger a workqueue for case 1)
> and 3) due to performance reasons.
>=20
> Hopefully I show it more clear.

Makes sense. Thanks,

 - Joel

>=20
> Thanks,
> Gao Xiang
