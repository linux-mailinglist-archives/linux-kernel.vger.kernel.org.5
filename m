Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101A47C8B17
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjJMQ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjJMQ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:27:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87A5EE;
        Fri, 13 Oct 2023 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697214245; x=1697819045; i=w_armin@gmx.de;
 bh=CVQm8LoNgvVfXdiZgWsMZAe2kCFpRmb9gu9VWobI3Ak=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=rS5HIDc29yY5lvCJRzumFM3VDPqoh2g5WTfNa4ZnWya1uPjNmJ5RN8FDYvNXaYX2sSnDLpHjmhZ
 x56uPaYzpC/KxcMsVFzfq7vS5KkFmprjown2xJBIKDepRduox/17f/mYHbP4OgNrAkDoYIbA0L8Hu
 eXnlYwi4tRkhUrmbkrNj5v94EdZ7CmcXoq7EMkVCvndF5e2pDVIC8dWn/44DhOKAHQNJryEr8bojA
 Cu+IrGfkoRObdSAmQpZjaGY21QTVm3f2Q4qBBOkez1FEnxOaYfAr/H+DM5qPReDuN4MKWkELddwwd
 HIT0QFJ6t5bZ5WSsT1eBrqffS3s2MmhcDHwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK0R-1rhvXg1Wsr-00rHe1; Fri, 13
 Oct 2023 18:24:05 +0200
Message-ID: <896d6ea7-f258-46f3-aed8-80c0a372e7e1@gmx.de>
Date:   Fri, 13 Oct 2023 18:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] platform/x86: wmi: Fix probe failure when failing to
 register WMI devices
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20231007233933.72121-1-W_Armin@gmx.de>
 <20231007233933.72121-5-W_Armin@gmx.de>
 <6fc5eacc-15e7-8de4-a031-d57ae27568bd@linux.intel.com>
Content-Language: en-US
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <6fc5eacc-15e7-8de4-a031-d57ae27568bd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EK+Efva867AZQd/pngXuCRoMSWCKsbU3BZ2LoSxyFTtKI/9Ls/8
 7AESfO8NSY++2ZAJxEcZqfc7Y+WulVTqN/u5egAVKNQNXbA2jhEaWQTlsp0tpnB+nqQ5bCE
 i/+QsgFg7L4qF6HjoH5vz0RI8CnaQW3xVnYlAcKHtDITKPOTs9AsctbLu9jAAduVPE1Vdux
 l8jCLhe9NsWwhcY4TIPdA==
UI-OutboundReport: notjunk:1;M01:P0:yL7P5dpsr1Q=;FI74T1kRVwujr3ewrZDRZyodviQ
 hp8cED04DUAs6M5zJc3Bx+H/L8EGLJlXjUWCDJORwHyVK20GCH9kSY+3ABJ7URoUrXvXhsNjt
 6sOK+vvmOYusms6mhEd4IB+E1CWelQlprVm2xcmKJHSQd9TRa0w0d9CpLlJN+P7+6bwXjEOQ0
 O/BrAIw2k2Xi5X0aNYkWWcixM4Ds6GgG5QwtaO534eAcB0IzyyhmJTgfcAaLMQ5Y9XKlzq94K
 I1tai+SvuqkrNNdUBvnSpdo1BjhJ7epn2fh+yP9P+DalGmw1Dgg8KRG/TMk4+IUMXM7otv5OC
 WPkxXRUOFJKs1dfh33ADF+bA+yHRGarZH+dlbP+xpvtV0+UrRE6oEfdvyhPMIMZtc06zYmZbH
 /ZfRFRi/xV0sXptqsAJ3UxoBLAIdB13rDQoy345qlX2qzf2+kqZSYTB0QMyEnnacvKBIuDcwx
 aPbN/glVgxQlEcw+49Cn2KCYXmoUT/TCSZpAsJlNEJtVSwgoPkGLvg9yoXLNLJtlxHX+zNHZS
 vAk93QHf0udxj8fpIruiIwWjH8uV2GBe+fgtoNI424Bcl5pWHo/U9VaJmDuL30rlVBpzqnkGO
 v4NL8369UTZ3EXk/W+El1TFLpLFcHR3z2kdt54SDfuy6eIP4ulN0jUD8t5gVhe9ZIwR4cm2eO
 n8cggNNF1ZqLaDUKBc2R4rAtJHZCkCU8NFKKy0xD14no8qIgyfsadaYhepu4IMhZI2xWbnb8q
 XlvI5LKIIrNZ/1bFaYc3lyFGQFdev8C/lPzaKyjhRTF8FqAWK5W3qPfhtVkV3v9d2D5iAM8bO
 O0syXu1mbEoKjfd9YpCkCn6SSXu0YbuyHrT2FtjzrA6PGAgX7OOHmMyna8Z0wHq4r4NCansq0
 petLHZJ1t7P6YYfY8xq6gk3zgbQBIEURYD4E0wufqASVNm2Mp5YL9ohe6jdXGeuXczAsMYLF1
 UFJj/lHVJ2pj9FVgL66pdRK0o7Y=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.10.23 um 18:32 schrieb Ilpo J=C3=A4rvinen:

> On Sun, 8 Oct 2023, Armin Wolf wrote:
>
>> When a WMI device besides the first one somehow fails to register, retv=
al
>> is returned while still containing a negative error code. This causes t=
he
>> ACPI device failing to probe, leaving behind zombie WMI devices leading
>> to various errors later.
>> Fix this by handling the single error path separately and return 0 afte=
r
>> trying to register all WMI devices. Also continue to register WMI devic=
es
>> even if some fail to allocate.
> I think the usual approach would be to unroll all registerations done so
> far when an error occurs while registering n devices.

I agree, however the surrounding code unrolls only the WMI device registra=
tion,
so i kept it that way. After all, this patch focuses on fixing the "zombie=
" WMI devices
problem, so changing the code to unroll all registrations should be done i=
n a separate
patch IMHO.

Armin Wolf

> Do you Hans have something to add what would be the best course of actio=
n
> here?
>
