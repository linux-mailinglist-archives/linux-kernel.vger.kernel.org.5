Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DC1782AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjHUNp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjHUNp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:45:58 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D394FB;
        Mon, 21 Aug 2023 06:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1692625553;
  x=1724161553;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=MQdmWqNQajJmWoXPlqJR+8bjrqdRLEAq+htHeeP1mNc=;
  b=njzp49B0k+V5Qa+TCq40ndhWjPouGr34TOH6Qv5hWJhetxMkfJYNG+zo
   TomrLGJYJkV8cG4aaFX5YL8vEF+bhOrwxbUR2DWAw485AROMSjMiN6f/N
   lai/lxW1qowcxFQSLFS3veuYgetZ8fS58/a0crs/TG36lXOXUUmiRi30z
   /WmN4uNPbFJZvNqVFw/aR713pFOs3B9Z0xQxqKV7XDTOw4Xv35bF3BCxG
   IQ9eH42ho5jDpe8+xyQp8GAMFKrO+c/VLr3OJ9CsFUoQbIpvMruWoAI1K
   LDkOYvR7iIzgyLf40rhpIRwJ9Ds/JF7lO5KIlie4/0a5Usxt6JwXZPRIc
   g==;
References: <20230810035910.1334706-1-gongruiqi@huaweicloud.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Kees Cook" <keescook@chromium.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        "Wang Weiyang" <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, <gongruiqi1@huawei.com>
Subject: Re: [PATCH v2] iio: irsd200: fix -Warray-bounds bug in
 irsd200_trigger_handler
Date:   Mon, 21 Aug 2023 15:41:18 +0200
In-Reply-To: <20230810035910.1334706-1-gongruiqi@huaweicloud.com>
Message-ID: <pndsf8cse40.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail02w.axis.com
 (10.20.40.8)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:59 +0800 "GONG, Ruiqi" <gongruiqi@huaweicloud.co=
m> wrote:

> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
>
> When compiling with gcc 13 with -Warray-bounds enabled:
>
> In file included from drivers/iio/proximity/irsd200.c:15:
> In function =E2=80=98iio_push_to_buffers_with_timestamp=E2=80=99,
>     inlined from =E2=80=98irsd200_trigger_handler=E2=80=99 at drivers/iio=
/proximity/irsd200.c:770:2:
> ./include/linux/iio/buffer.h:42:46: error: array subscript =E2=80=98int64=
_t {aka long long int}[0]=E2=80=99
> is partly outside array bounds of =E2=80=98s16[1]=E2=80=99 {aka =E2=80=98=
short int[1]=E2=80=99} [-Werror=3Darray-bounds=3D]
>    42 |                 ((int64_t *)data)[ts_offset] =3D timestamp;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> drivers/iio/proximity/irsd200.c: In function =E2=80=98irsd200_trigger_han=
dler=E2=80=99:
> drivers/iio/proximity/irsd200.c:763:13: note: object =E2=80=98buf=E2=80=
=99 of size 2
>   763 |         s16 buf =3D 0;
>       |             ^~~
>
> The problem seems to be that irsd200_trigger_handler() is taking a s16
> variable as an int64_t buffer. As Jonathan suggested [1], fix it by
> extending the buffer to a two-element array of s64.
>
> Link: https://github.com/KSPP/linux/issues/331
> Link: https://lore.kernel.org/lkml/20230809181329.46c00a5d@jic23-huawei/ =
[1]
> Fixes: 3db3562bc66e ("iio: Add driver for Murata IRS-D200")
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Waqar Hameed <waqar.hameed@axis.com>
Tested-by: Waqar Hameed <waqar.hameed@axis.com>
