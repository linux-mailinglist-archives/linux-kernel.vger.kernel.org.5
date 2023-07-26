Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55197763A76
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjGZPK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjGZPKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:10:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234D52D6A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:10:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so92715e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690384196; x=1690988996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIDJxMvMWjb2ZMMRY6z7HMerL44iWnloZy3fk6uRKdA=;
        b=ktKWWOJ8yocg1qv8xqc3iCGL70fZ/tYfna1yJPbQOuK6JxGIDXdlBti53QNDgeBEUz
         rSGkbQvXx4lN2Gpg9mGCmY3i6rW9/i8sSoH2pEzQL+3Kmkeid0hRW7ZwzhJWsWrOQcme
         GLvrxJyMkoCEROI/EnzJbFNctkNug78GmCn0co/3ABbv3tyrxylcPlrhNauTdmBACxIx
         dG7RS1gcQAuewYCEcLEnGOVTo/Ql9pWOCiE75xYxvVBwu+3In3fiByOtDCDO30nwilkw
         DxqtHYNFPm0rkqok5lpkSuhx3lp7BSkVqfrKsNULPiL+yyXx8vYmk1ROuOhq1rjCwmbd
         EcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690384196; x=1690988996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIDJxMvMWjb2ZMMRY6z7HMerL44iWnloZy3fk6uRKdA=;
        b=kUJAOwRlwCcgN1JLDY4jRiWXM7MvBwnQMdwugS15seBxJ1pKeq6TIRoRKspoJajZ/B
         hmI0T3qYVYRVUcAFU+gBxq/s3PwynA79JaOeWqTYNkIsJQ0TBlqlKcGnVyxoxduTp08n
         w76mFmLCEYvg+z1NfsO6+j1quUjJgv20jzBWH6GpkRoyfrBkycZLr8cfwfo48KJlKYOM
         FK8Qx6dU2lmMo44r0pDrnciJWhi83lakOoKKhd/qHFnuBFCAvG9l42Cf71SYXsy8pXcw
         5J1nO8X3isZKMNysYRC4rB++jpDSmVsBduv5DEO8jDVTwGxYvBft6pn793GSf49NGHkT
         1fxg==
X-Gm-Message-State: ABy/qLaJhAwE81Q4Div16gDXHc8L2A4ipfVQI8i/+kLyr6p1Md+VHd9r
        NuI04rNVsyyzdLxouIWKIleKcY7tK/ari703s3BSzg==
X-Google-Smtp-Source: APBJJlFMrYG0fRVa96eL8vMcZWqP86Lvlb0UCs77E7/dASW1i+z4fcEOahx9NSDW9VqWJCbeZZqWfRHs/dBtvIHo8UM=
X-Received: by 2002:a05:600c:8612:b0:3f4:2736:b5eb with SMTP id
 ha18-20020a05600c861200b003f42736b5ebmr211152wmb.1.1690384195813; Wed, 26 Jul
 2023 08:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002b5e2405f14e860f@google.com> <0000000000009655cc060165265f@google.com>
In-Reply-To: <0000000000009655cc060165265f@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 26 Jul 2023 17:09:43 +0200
Message-ID: <CANp29Y7UVO8QGJUC-WB=CT_MKJVUzpJ2pH+e6WAcwqX_4FPgpA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] KASAN: use-after-free Read in qd_unlock (2)
To:     syzbot <syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com>
Cc:     agruenba@redhat.com, andersson@kernel.org,
        cluster-devel@redhat.com, dmitry.baryshkov@linaro.org,
        eadavis@sina.com, konrad.dybcio@linaro.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 5:03=E2=80=AFPM syzbot
<syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 41a37d157a613444c97e8f71a5fb2a21116b70d7
> Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Date:   Mon Dec 26 04:21:51 2022 +0000
>
>     arm64: dts: qcom: qcs404: use symbol names for PCIe resets
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17b48111a8=
0000
> start commit:   [unknown]
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfe56f7d193926=
860
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3f6a670108ce433=
56017
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1209f878c80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D111a48ab48000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:

No, it's quite unlikely.

>
> #syz fix: arm64: dts: qcom: qcs404: use symbol names for PCIe resets
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/0000000000009655cc060165265f%40google.com.
