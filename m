Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C1880C87B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjLKLu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbjLKLu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:50:57 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184FAD0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:51:04 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-425b9acaf80so14113361cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702295463; x=1702900263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFlOaOKOFTUGeU3hihhI0E9Jv6p6CgBMgpCcvHMWbLI=;
        b=u17OW6FU+I47r/XfAcb5vP+2Le80pD6d5wdDVFKE2j5qnRsm+J0UIuKmqaMMryr1M+
         CjsaO3aTGMFOawVCEqypHSyz6TV6RHpCuu4Fxi9ZTvs5umRG801QflWNLjzkR4OEYt3Z
         4M9YKCjq3rygkxRn4mxKpPYVQsnXYwy2zxJ+8xtCTzArc4HSlyh5z1Yu7qkV3KLrapuV
         30AzzCqO5sh4QRiWlJ5xW2C/dNKvDpkVSkC49ezfICTW5OpDSdk7mPmL4esqg+xsEdb8
         zRezW5po+CbeFBVl6pOlTzs6HdwBER4EZPEAGvxtsISuAbxBJ5UBfI0crUGleB2ViKRy
         J5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702295463; x=1702900263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFlOaOKOFTUGeU3hihhI0E9Jv6p6CgBMgpCcvHMWbLI=;
        b=e/zg37Dqpr6G+yGL+7IFZzSNtgXwqs9ujdXtUmiULppMXqkR5D6Vi+GhiY3KQoB632
         cueVO6Wwmd2glV8tAnYorlKgGeeO77hmTgRFXRLK74HJm101TYyoWVIJqdQYlJEhhMoz
         thUB7ACgXBueWdfCGAcbN3c80rVPk9gLEJvI3C72aAocOYMtIcGgZH/43w5sYSCvN8q0
         RvEpof9EiH/+v5OyA8+y1nKvxOI1kiXiYlasjaeBfS+gnymhRxpmz9+iB0uYp0woLGf0
         ZENZv+15djjpAhTrTUh2f6jQ54oghTEU24KsNh79/eb/MjFryUSg8hSuVdcOTP2M5ZEV
         ElXg==
X-Gm-Message-State: AOJu0YxLo/+dP9G2HmaWa6ysfr9zK6w6GZuI0u5jeQaNt8vZCxW0UrMe
        l9Bd61vpraLoZ5lqYdB5jCGoS2TtOQGH9YXj+a9Hkw==
X-Google-Smtp-Source: AGHT+IESpOk1+13dVI9Xc1VuCWEKnD2SuIEKb3OpBVqsUwAw0LqpvmwqlMYZQkeY3oFDarm5X4BCzXvYf66ohaO4eV0=
X-Received: by 2002:a05:6214:2626:b0:67a:b923:6ae2 with SMTP id
 gv6-20020a056214262600b0067ab9236ae2mr6255559qvb.23.1702295463057; Mon, 11
 Dec 2023 03:51:03 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-13-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-13-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 11 Dec 2023 12:50:22 +0100
Message-ID: <CAG_fn=VaJtMogdmehJoYmZRNrs5AXYs+ZwBTu3TQQVaSkFNzcw@mail.gmail.com>
Subject: Re: [PATCH v2 12/33] kmsan: Allow disabling KMSAN checks for the
 current task
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:06=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Like for KASAN, it's useful to temporarily disable KMSAN checks around,
> e.g., redzone accesses. Introduce kmsan_disable_current() and
> kmsan_enable_current(), which are similar to their KASAN counterparts.

Initially we used to have this disablement counter in KMSAN, but
adding it uncontrollably can result in KMSAN not functioning properly.
E.g. forgetting to call kmsan_disable_current() or underflowing the
counter will break reporting.
We'd better put this API in include/linux/kmsan.h to indicate it
should be discouraged.

> Even though it's not strictly necessary, make them reentrant, in order
> to match the KASAN behavior.

Until this becomes strictly necessary, I think we'd better
KMSAN_WARN_ON if the counter is re-entered.
