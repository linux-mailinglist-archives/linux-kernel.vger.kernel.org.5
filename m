Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDDA75B728
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGTSyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGTSyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:54:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C01705;
        Thu, 20 Jul 2023 11:54:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bb1baf55f5so8534535ad.0;
        Thu, 20 Jul 2023 11:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689879254; x=1690484054;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRq4kiOe6o3GCeNturgO6VEAqY0DWx/wr2Uqp7KCQAQ=;
        b=fNQQbA+N7NG8ROfS0eyXZ4nfFd3AwMKZfpfL9lXlvgIkkHfN/3GoQG+tX3ehHsb8dv
         wGbxzGoTR581bIPQCfdzJRLm4LeVfm9Kcticw1Jd0mlKfxKfL47vahmEoZ0aeo26qApz
         tZw3W7WeCo6PYtJqfPkdXYpRjSQjKdveHSHQQZtG5SJWaAtwAVzUxskYt9VVOPmYHvSG
         m1nLU7HpvcwZCmHKeGfG5qQqvww+eezcjosiQfsJwq9VLeZcPENHUXXbttAxdxyunlqn
         0BfdyhYgOUXAij8+5K7/S1BnN2NrWmPUopT0O824l7MoAqrIqkvPPgIVsp1KGXvkbFSi
         mmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879254; x=1690484054;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRq4kiOe6o3GCeNturgO6VEAqY0DWx/wr2Uqp7KCQAQ=;
        b=dvcQo+LFj/gEuYAscUDRHnP9nczYY0lOsYfIZ9mZ5/3rrV6ZjRWIzHep0O7QdkrcZx
         wJmJgofE4C/IwZTUoXtlMfIlHYPfqLNaMn8DFpHe3dGRKMh6EjUQeVCrDr4dmKWbdI5k
         GAb3qbnLKyfB7qdIo8Wk+TPUWNk7pd2kPUYJN23KInQhlnKh4lLGdNjq0Z0jLJvJOkyL
         W3OHOvlOtFfKD8cvmyFIXfotuAWEWM0npOrUm53xy6fvtwmSoIFZkyCiUzV2eZ8wtqhA
         FrnT62qQNVDOsvrMUTJC3u2DPGcx+92ECRgDt2IrVjV1SssHyR2LUeDFBiezmQeXMYyC
         ibuQ==
X-Gm-Message-State: ABy/qLZTKEzPM68atkk/5TAG/+4SWFWTWyVAZdf7OTCMHLhXmn4uOI75
        tv7LyNDktqEjOzKhnwD47ogLwwtT9P0=
X-Google-Smtp-Source: APBJJlHzuCcODyNyT6KQ00oY5CFkyrzoStrZfVAbxsa0cZRpGI+a0UvG2ODhZLQ/Id7StLYc9sd8Lg==
X-Received: by 2002:a17:902:e883:b0:1b9:de75:d5bb with SMTP id w3-20020a170902e88300b001b9de75d5bbmr217104plg.7.1689879253780;
        Thu, 20 Jul 2023 11:54:13 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902d2c700b001b9c960ff9bsm1762792plc.78.2023.07.20.11.54.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2023 11:54:13 -0700 (PDT)
From:   Alan Huang <mmpgouride@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Message-Id: <04C1E631-725C-47AD-9914-25D5CE04DFF4@gmail.com>
Date:   Fri, 21 Jul 2023 02:53:53 +0800
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Eric Dumazet <edumazet@google.com>, roman.gushchin@linux.dev
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rcu@vger.kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of first =
item in hlist_nulls_for_each_entry_rcu=E2=80=9D)
and a related discussion [1].

After reading the whole discussion, it seems like that ptr->field was =
cached by gcc even with the deprecated
ACCESS_ONCE(), so my question is:

	Is that a compiler bug? If so, has this bug been fixed today, =
ten years later?=20
=09
	What about READ_ONCE(ptr->field)?


[1] =
https://lore.kernel.org/all/1369699930.3301.494.camel@edumazet-glaptop/

Thanks,
Alan=
