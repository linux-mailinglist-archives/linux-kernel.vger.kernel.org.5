Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D2F80A900
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574109AbjLHQb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574071AbjLHQb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:31:56 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F861986
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:32:03 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-58d08497aa1so1141680eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702053122; x=1702657922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sqOsISr4A6CIOB02HqyYbsWnQIUDQQ0cX4xtpbDCng=;
        b=iqle0iK70r7pqT5OYWAQCgwCHN3//A3JOwSyNlG6jMe6rI7p7VsXp6tnD0okNWhfyG
         GDS5nDkyqmttX2Y1P5eH5DJ9LTF97mgtFYvt/KAYfRF79WfHg0XeiRxoe6gGf63VSmb9
         4+cvdtKhHAJC9m7q/XPZg0wwm8Y0UztbglhhKDmw2PwpS34X1rYGbdudSS+daobv0NGH
         xM7ToxrbRZQMJW3eb3XpITf03W/WJezZM6BpNLuxDZEb7oOSPcREQ2o9wkAJ0ka08NB4
         XcPpgMf0//yJHvlPRbLykhHmDKQhaqBRJK784pv5t2DqharXMSmttOlR03Bp79h6XX4J
         wz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053122; x=1702657922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sqOsISr4A6CIOB02HqyYbsWnQIUDQQ0cX4xtpbDCng=;
        b=MwY07utUmN8k/fQurArYqY9IYJA90JLxDJVPcYfgBcww1y+KEXRkYn2KGmBKM1gmH8
         ylWgNkA00RyT8ruDzqfCVQF1McQscndWR+LET3T+jPuRVa3sGeUBCj1MSJoIrcaWWUNS
         JImVVrowBnmE+t5Hpp3gLFBo86hocsuxa+KT1GslLOcQrf5AsB6DzCRst2CBVLNctv2E
         Pa7QHawdjmVvfP1haH/qh7PPfC2BveHA4aADGckcM+EQuO+lNdnPiLwyjM5wILjqM4gM
         3OVoW+5u+siIJwirV55aRTd4s9o8BhNaShlz6V9QUCLmGmDMZ5xyO4ksMfjvCb3pNbRi
         fkng==
X-Gm-Message-State: AOJu0Yza/K3vWvfZpRkEO904VTkxnbHtZdetQIMj4Us/aemEE2Vru6MF
        tdH0oE21FWsKuv5vUv/HC1WMRuruCnFq0PKBOHqBtQ==
X-Google-Smtp-Source: AGHT+IH04K90iuM9X1mkjifO4TvAKhiYyXmU1LNL55T1W04MJ1jjc5+Vy90i3bYg2jhfMs/BJZ+7n8AlC4vX1LbSMS4=
X-Received: by 2002:a05:6358:7f13:b0:170:2c2d:9d8f with SMTP id
 p19-20020a0563587f1300b001702c2d9d8fmr209508rwn.1.1702053122541; Fri, 08 Dec
 2023 08:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-5-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-5-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 8 Dec 2023 17:31:26 +0100
Message-ID: <CAG_fn=W_aH5a5grk63Uwx0Dq-dvdafAriBc3v5YtYA4cXiuJ7Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/33] kmsan: Increase the maximum store size to 4096
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

On Tue, Nov 21, 2023 at 11:07=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> The inline assembly block in s390's chsc() stores that much.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
