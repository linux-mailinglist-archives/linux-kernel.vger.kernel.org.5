Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9676780A488
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjLHNjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHNjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:39:07 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E7A1734
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:39:13 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d9d209c9bbso1456017a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 05:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702042752; x=1702647552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rN8Rat4FZlrJAhphwUeTKAqkkJCDvqW2t49f375msAs=;
        b=hGy5kX1toSBypw4ZLPXDuL9hcokhSZB2g+qGSsSOf0cso9ZsPKp9DCbbuaU7XDMaiE
         j31rp1vUW1TiO8kY2Xh716R+RcsHZ+OSUkysX7VF/n7vMx6Q4cgE76oh/ELomjdCVmSF
         E4NDDaPAddfLOioRDkzq3nwqtl8odhWAjBQhTP+NAI70bgxmEJT+P6UbleA5W3Cgwqu8
         aDR1oKJlEMw2CdN0OQTOdoLW9UHcR0Gll/nrl1JvDrh3Ta17n7tV0JJMq7E7BQvUGuyN
         VJl2Q7bCfAIKY1xUmCrmJzvsA/jEyeZUfW2k1QI45d8nvIrdN45LFSfPNddfHdZaDADD
         3zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042752; x=1702647552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rN8Rat4FZlrJAhphwUeTKAqkkJCDvqW2t49f375msAs=;
        b=dnrOgoh5nYOpG+sCrG8eZAxI+77rsOdYs0Ks6Enp0NJVXPuajwFI4UZtkbKiZWvoIr
         vawm6jJXHq5DQjNeAP04hugX/5QNI/ywNoyNqBC/mrBG0EqKpk1dDk1MReNnpNFaSIFg
         65l2ouW7CMWxKBXJYaS1zcW0ztWurJvmzU0wJPP2DByzwLt6CPFPGmCcWq3W0CMjnmTY
         NtFfHKeW937W+jLnZOmLHS6t8H9wWpwzyH5MrpXHBowa/g+QaaNAOtHLsdJhWknQZoaZ
         Lc/PGP02kzH35EKRKVpEeaW5ih7raUGQYnZ6JsAhLvNVLSECb9RTQ23SBxbqC1RZyFtt
         j51Q==
X-Gm-Message-State: AOJu0YzMHrxss1UqUBXC6QS7rSSVXQUnE30jTAMWrPIM+SfwqKiFESfR
        QGZ0N1riauOZ263oAPs9L/7xt72ULEBLKbJpgBEsLw==
X-Google-Smtp-Source: AGHT+IEJXKzONP7C4cAEoOMzT6ZeTkshs4DU290kKfRkkOzICnszoAWUTV1A4DlsnRvXpiN/Sz4G5aKQQ3r+jLf2v2c=
X-Received: by 2002:a05:6830:1a:b0:6d7:f363:eb0 with SMTP id
 c26-20020a056830001a00b006d7f3630eb0mr39559otp.35.1702042752413; Fri, 08 Dec
 2023 05:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-25-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-25-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 8 Dec 2023 14:38:36 +0100
Message-ID: <CAG_fn=U8kGUCHQb7580bfVgh9=E1zjch3vB0tV5ooFxWsGNQkg@mail.gmail.com>
Subject: Re: [PATCH v2 24/33] s390/checksum: Add a KMSAN check
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Add a KMSAN check to the CKSM inline assembly, similar to how it was
> done for ASAN in commit e42ac7789df6 ("s390/checksum: always use cksm
> instruction").
>
> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
