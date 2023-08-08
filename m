Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2860774322
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjHHR50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjHHR4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:56:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737DDBF573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:25:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so87175e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691511927; x=1692116727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwAW4asVrEkUVVSKI2WNTJmzRtpxh5nDYHP0xuDjc0s=;
        b=xu/5HACllOhBYFuj3JchAnkZdzTuqlD35oZrtpM3qCDnIjwmCvCZSxkyJbkalZ9nTE
         5LaFtS56p4mG4rYiSrW2bTHccn8yys9u82MtU0lQ86KrdhA7ibF+CruTW86UZyxp3JXm
         UziNamr3brMAcCPCWR6cYhlUriyogeM5mNeBzHx3FfLBlLYKnfd1oYLY0iJKMGPPfz7k
         /Vju2LSQi31NZRWAvODXu9rTut1Uu6SotyaThLhqcSDJLlpLBhRxsuJ+5UAZH+7TjBwT
         6ZoOUDxAg2CfhT3B0C4KBDr8eITKh0C7VpSDSGi1u3bSuQ0XVdzTeQ4LazztBTXMDe8R
         9Hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511927; x=1692116727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwAW4asVrEkUVVSKI2WNTJmzRtpxh5nDYHP0xuDjc0s=;
        b=NASPpcwYcp6GRLVDZ0Vb0Biy+0yw2yZ5lYBqky7rZPPjd2nDxNeSutnVYm5qXVgurz
         g4NSF87xClRnI6laIf2TZ6+IzItPfajgULcIefTez9XSWt7X/eXtQHWsN9nr3eEC2Vjm
         452Jp5ho9IG7uBEJ5/l4h2clcIA7hpp5yU2euBabqsEIyXBXu7wVF2o9OG3ujr1HAVNo
         EcYYJq1RgPcWQkizqgxdowf5OBFE6osGYXiUObC+R2S0loOZs6TGgamSbTD91mEGyBjL
         ZyTQMBbjVgC0V8UQcgQvegaosDFRIzMi5qktW5K2k37OnOjPpDB47P8E+zzhj8pocVaX
         oh4w==
X-Gm-Message-State: AOJu0YylYW8LoWBpsSgJfC27vynmY5QImhFLc59gXigf2oGxestRwnoJ
        lLVHkmHdT9DIi605c294IScE9DAMTpy8bHT/KjEIOg==
X-Google-Smtp-Source: AGHT+IGCuc1ECA/DdvhuJs8hrdI6B0b0q+56VMbNGS79u6n7XtDIRdL1Iu+hAqJPTrb26LRWfquYy88hAzXnhi0ISBA=
X-Received: by 2002:a50:f61b:0:b0:523:193b:5587 with SMTP id
 c27-20020a50f61b000000b00523193b5587mr283949edn.6.1691492435497; Tue, 08 Aug
 2023 04:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069948205f7fb357f@google.com> <000000000000a9bf5106026705ec@google.com>
In-Reply-To: <000000000000a9bf5106026705ec@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 8 Aug 2023 13:00:23 +0200
Message-ID: <CANp29Y6M-CU+eqUFqN3Rkf2iba7upqsLvnHNNyMmhd4JFdH-8A@mail.gmail.com>
Subject: Re: [syzbot] [fat?] possible deadlock in do_user_addr_fault
To:     syzbot <syzbot+278098b0faaf0595072b@syzkaller.appspotmail.com>
Cc:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 12:42=E2=80=AFPM syzbot
<syzbot+278098b0faaf0595072b@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit ff84772fd45d486e4fc78c82e2f70ce5333543e6
> Author: Sungjong Seo <sj1557.seo@samsung.com>
> Date:   Fri Jul 14 08:43:54 2023 +0000
>
>     exfat: release s_lock before calling dir_emit()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D16623aa9a8=
0000
> start commit:   f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5'=
 ..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3c980bfe8b399=
968
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D278098b0faaf059=
5072b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D144ccf79280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D135fab7928000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: exfat: release s_lock before calling dir_emit()

Seems reasonable.
#syz fix: exfat: release s_lock before calling dir_emit()

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
d/syzkaller-bugs/000000000000a9bf5106026705ec%40google.com.
