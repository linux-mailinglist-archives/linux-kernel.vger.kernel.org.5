Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FAE780266
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356508AbjHRAGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 20:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356621AbjHRAGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 20:06:25 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B3E3C03;
        Thu, 17 Aug 2023 17:05:59 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77acb04309dso12134039f.2;
        Thu, 17 Aug 2023 17:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692317158; x=1692921958;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwIzvkMVcbe5KhN4zVEidAVbcmW0cSGczFrySv1jt9Y=;
        b=XFOqiwvfsHigbIpnmkkVyyimhSErU+38ZS55U/vBGL669h9pSr9dbMbJ81jdXF0x4b
         hNAWDr39jKDY/1YQS0KZ3zSolIbsADg3kwU/q69wpFloooI7I5sAy+XVRYKGmpftkb1P
         YP3/hdmUgKckskoTuxer1ZnDUkfAfKzPy1jy0MG2ihJUU9ZSKi7rTpys32PIOib2AWIo
         dwUDJPCwy9KmxofVrYQ2kD0aWwgyLOHsLCfoQ0I9Qw1PMgbtE4xUHJWQhl52Jzg5mNuf
         guyVZLMHcbdVmAICTVpQcBsxatovBsGSJktycjX+Sr1TpSuJH1VurpGnImYVcE4H6gmZ
         W7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692317158; x=1692921958;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwIzvkMVcbe5KhN4zVEidAVbcmW0cSGczFrySv1jt9Y=;
        b=VSDj55FXxG4jiNPwxKzZAma1kqgvTXl5sQSAWYd+pcj1W5OChFJsupg1HRQstBlykM
         MGa/2Z516wT3wBTpXv6SzDDmsnmuDI/AKKctJ9siinfZ4wDQu2mKAApskqxAnuMtSJ5a
         tVzR0KmdJkiQHDatsKKTXro8pYvTM5bhW85WYQz5Wh0BFVcs4zC5qQdc2JKgdqxQW2Ul
         A/sUuSHLdD+UVcgUjM5y++mH7Wzrk3B9vsKuQ4X7hBJIKxg2N9JY0We043Jn7OfEJYC9
         Xj/KIU3g9kkoRoZL7mqbimOvo7j1+qOhwAOPyW/ROx8aLbSRzdf4LQ1gBuxwHj7oFpcD
         vY4g==
X-Gm-Message-State: AOJu0YzCA8bXGF7fVKC0bHfXMjh3l/2IpE1Kspu6/+GnaUlp7DwyR7r9
        ofGw8Tpvc5GfWxcR4ylDvlhGYWWx2thMOw==
X-Google-Smtp-Source: AGHT+IHStbq3NzN6dQNQrKWqG9jcfAu3ohPaix1q5u++4r9w9pldwgzS8TcP7SxxfZu2vO8zK8EkFg==
X-Received: by 2002:a5e:c60c:0:b0:786:f352:e3d4 with SMTP id f12-20020a5ec60c000000b00786f352e3d4mr1393419iok.7.1692317158484;
        Thu, 17 Aug 2023 17:05:58 -0700 (PDT)
Received: from smtpclient.apple ([195.252.220.161])
        by smtp.gmail.com with ESMTPSA id fn11-20020a056638640b00b0042b482a8763sm167066jab.70.2023.08.17.17.05.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2023 17:05:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH] tracefs: avoid setting i_mode to a temp value
From:   Sishuai Gong <sishuai.system@gmail.com>
In-Reply-To: <20230817200044.373f9655@gandalf.local.home>
Date:   Thu, 17 Aug 2023 20:05:47 -0400
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E3B862D-9B74-44FF-B4F9-C0D7D0030EB9@gmail.com>
References: <10CFECF7-B9FC-4562-A445-4811F4C27655@gmail.com>
 <20230816155245.6ead4384@gandalf.local.home>
 <A9B746AC-DF36-4ED3-BBA3-2EEC1BA166C8@gmail.com>
 <20230817200044.373f9655@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 17, 2023, at 8:00 PM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
>=20
> On Thu, 17 Aug 2023 19:47:34 -0400
> Sishuai Gong <sishuai.system@gmail.com> wrote:
>=20
>>> Can you produce this race? =20
>> This data race was detected when I was testing the kernel (e.g., =
fuzzing)
>> but I did not make the attempt to reproduce it.
>=20
> Now, I'm curious to what exactly is this fixing? The intermediate =
value is
> the S_IALLUGO bits cleared. Doesn't that mean that nothing has =
permission?
>=20
> It's not a big deal if that's the case, as it just means things are =
locked
> down a bit more than normal.
You are right. Even if the intermediate value is read, it is unlikely to =
cause anything
serious. The reader I observed is acl_permission_check(), which will not =
be affected
by the race.

>=20
> My question is, do we really care, and why should we?
This shouldn=E2=80=99t be a serious problem. Maybe we could consider =
this patch as an
annotation to the race.

>=20
> -- Steve
>=20

