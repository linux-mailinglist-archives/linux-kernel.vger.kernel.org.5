Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF714769D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjGaRC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjGaRCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:02:11 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687372115
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:01:38 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77acb04309dso252174739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690822898; x=1691427698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E23qwAQJvXasIhgQsW92y++GdBjVpFQZpVbqevq6H4Q=;
        b=zb3gg7GQJB/7cEwbrMVtQQFSIU4nzuhj9tjD39E62Orh+mwqAt08FgoS8UGvlpxHy+
         WpU1y35yK1a84D8PlA/aE8zRY4094UIUIZi4GBAAOAeUlq1HbtlHxWmS18XCNlpX+cwT
         xZbK/UspFmVEHLV9KSasqC9I6rMN1M9hih/KIdaZA1Xne/tc3M2Im9685XxEtMuJ+GNa
         MxMvSFi3KqsIWkoKqIdLrb5ozFPp16YeWvIv+guRtX2MwU4hMlQ0MSCPizozdGHMibBO
         0uSg54KkxvdSGav3+LVLvia/SRhtwCVvNbt3mKJjdF4PD0XHHa+Fh9tVgNZqDEVi8Cny
         oU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690822898; x=1691427698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E23qwAQJvXasIhgQsW92y++GdBjVpFQZpVbqevq6H4Q=;
        b=aJ0gLvJ+q2UUke9l2OCVWY53EJCB9cj8c6OgJ2SZIY8w9FcNJHObIjYsqUx6l1rdjQ
         lERQzfaqyk+AnDm3L9LHI1jV1Fp8odJZ2yYvf75gXzf+SMqPmqrXqecUGER7ejfUkLSZ
         vhzonPbKoLljL1fAmge7eXQWvCK8fXw2Qt1RMbNkDFDOh9zTkwU80DUc2qxG6zo2S1k/
         hdPcZ6uYzVipSDyPpDUTZXIbmpdyu3g4+4TEOvt+Qm3Kw6lWS75HWVpP0mi3H9DGZD8i
         /3B0Y9jg92q+POtWZx8I44PZ0wtxNyScsWCd43I4chfYyLpjHmeSd1XIdrBxERIah3J4
         C7TA==
X-Gm-Message-State: ABy/qLZ2JYL8HrTOIYbb3pibnh5SgO9AWf5vJt+M0hO9cbaH7N5blaLn
        tdsvogYzdVa07ecyysfEBSobb4Bfsl3Yy3gx0ZfGUA==
X-Google-Smtp-Source: APBJJlHdHIV4fQD4waaiC8YiBWgnL/iaLt2cfa5TVyNmbwa46rBehS2G6kl46eqkihqj0tcpUEifCumGJMlQJlBsrSg=
X-Received: by 2002:a5d:9149:0:b0:786:ff72:8da8 with SMTP id
 y9-20020a5d9149000000b00786ff728da8mr10356593ioq.17.1690822897680; Mon, 31
 Jul 2023 10:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230727011612.2721843-1-zhangpeng362@huawei.com> <20230727011612.2721843-2-zhangpeng362@huawei.com>
In-Reply-To: <20230727011612.2721843-2-zhangpeng362@huawei.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 31 Jul 2023 19:00:55 +0200
Message-ID: <CAG_fn=URAW7=utEcN1Hs9G0mBsBGCA-R71PmzaVnWCNp-2rVgQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: kmsan: use helper function page_size()
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, elver@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 3:16=E2=80=AFAM 'Peng Zhang' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> From: ZhangPeng <zhangpeng362@huawei.com>
>
> Use function page_size() to improve code readability. No functional
> modification involved.
>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
