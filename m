Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCDC781FA4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjHTTwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjHTTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:52:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988221738;
        Sun, 20 Aug 2023 12:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E4E961003;
        Sun, 20 Aug 2023 19:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D455C433C8;
        Sun, 20 Aug 2023 19:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692561148;
        bh=ZTkfRlcTFK9Ko+bTjKIObYpHJMT1NgBiP3RZVEAT22E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5ZlwmM1gJ/XXIejNG7Zjv+0rfMkHUImsGKBVx6h0LO/F6hPp0LZJH+nmQHGMzZ9P
         CwIsj46BSY4+SLGusRQpXk5IGnkTkiY8u0SRsb71FYJ5rd2HqBrxXJ3ym2mnYKTK3o
         ute49ekqA7yarPS4uBe9OXtPNWu/j6V4ARArhIrp1Zeco7iRysdoJ223VgwVPnsqOy
         R5WVy8EBiJzfMoKDRsYmoiCnLOrxEc/tBGeGEU/NMJ5elej1P7SU9IcsOH/x1N3JB5
         i92CDMbrqlWJ7sAnDIGQZEkiGHQ+Gt/2iG7mktQJKXuo8hE6v1hTLY2uTd+DEmZnyA
         9dU/XmEguaOkQ==
From:   Alejandro Colomar <alx@kernel.org>
To:     qat-linux@intel.com
Cc:     Alejandro Colomar <alx@kernel.org>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH] linux/container_of.h: Add memberof()
Date:   Sun, 20 Aug 2023 21:52:22 +0200
Message-Id: <20230820195222.279069-1-alx@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZN8v/2McQboR3dIu@smile.fi.intel.com>
References: <ZN8v/2McQboR3dIu@smile.fi.intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3319; i=alx@kernel.org; h=from:subject; bh=/d99sq9rLDZ8l/JAmlYozPyQ8wTEgfcIzsGvYn8YdU4=; b=owEBbQKS/ZANAwAKAZ6MGvu+/9syAcsmYgBk4m6hMR8H6+j1zWzeDhUwHCzl18BhHXDxbUPJY XoYavXmI0qJAjMEAAEKAB0WIQTqOofwpOugMORd8kCejBr7vv/bMgUCZOJuoQAKCRCejBr7vv/b MjYGD/4s7i02H7bA09pSfjyYna3uR6nVCQjg52DM1/xxqI4Wi+99ovq9beyoOqiQy1ahflBcyeg qBd/IFcMDpXcg8Tfpbi/4UvS/IHmlRgQu7uPeimtRaWnE47ttQJ4mcQwj5xBcmrKiGMTjpbZCS2 rDEjM+7msoUDB4XsBqn3oqwxkyYgBdxmOx6dh6LBsg00IQqe+bAMwRNzdvM1vhDgJSyTc9nCYAt YVCOBJ0/wkpf630XgFoxXUZdoLEXS8aXwHWoc/Jp85TRtQ1DFth2eN0iY25YY8tvPVdm/ikIc6o Pd2QuQB6CkzlEZoazY2u0KEAqAHjcsFjLIhV2+5N2CbTvlrPzZ44srN0Bbl2ifTWQx6g0K/KQ1m jU94Ym1bU3nhSrZ7WL9S7TdMJKhWozKGCzl88qoX0I2zY8T6o8mPg7pdeh/4Qb0kdddfhu0h/Cf Nk2og+7W9QvkvpOEqfmrOzobRUTqZP+mgkWVh0ViUzI5TDelr1+ed3WlQK8eVY9C4vdzmkB6+8X zdCYdLzU0yISMEwKfpIU1hF2qca67ga9htJPOJ9eDTMF7hTWH6VoRw6HWrYjCM1Cm1BRbcZsfm2 zCIhqXXGYY3q/vF9a7DJr613PSWjlsJisaIsPLMuZcw7PbjYOqzddw3eG7cJileukaF0ZEmFDE1 QUCfYIEch2lqCiQ==
X-Developer-Key: i=alx@kernel.org; a=openpgp; fpr=A9348594CE31283A826FBDD8D57633D441E25BB5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alejandro Colomar <alx.manpages@gmail.com>

Hi!

On 2023-08-18 10:46, Andy Shevchenko wrote:
> On Fri, Aug 18, 2023 at 01:28:42PM +0800, Herbert Xu wrote:
>> On Thu, Aug 17, 2023 at 04:33:17PM +0200, Lucas Segarra Fernandez wrote:
>>>
>>> +static struct pm_status_row pm_event_rows[] = {
>>> +	PM_INFO_REGSET_ENTRY32(event_log[0], EVENT0),
>>> +	PM_INFO_REGSET_ENTRY32(event_log[1], EVENT1),
>>> +	PM_INFO_REGSET_ENTRY32(event_log[2], EVENT2),
>>> +	PM_INFO_REGSET_ENTRY32(event_log[3], EVENT3),
>>> +	PM_INFO_REGSET_ENTRY32(event_log[4], EVENT4),
>>> +	PM_INFO_REGSET_ENTRY32(event_log[5], EVENT5),
>>> +	PM_INFO_REGSET_ENTRY32(event_log[6], EVENT6),
>>> +	PM_INFO_REGSET_ENTRY32(event_log[7], EVENT7),
>>> +};
>>> +
>>> +static_assert(ARRAY_SIZE_OF_FIELD(struct icp_qat_fw_init_admin_pm_info, event_log) ==
>>> +	      ARRAY_SIZE(pm_event_rows));

How about the following?

static_assert(ARRAY_SIZE(pm_event_rows) ==
    ARRAY_SIZE(memberof(struct icp_qat_fw_init_admin_pm_info, event_log)));

It would only need one macro addition, without significant churn.  It's
even less typing.  Below is a scissor patch with the addition of
memberof().

I tried building the kernel, and didn't see any warnings form the patch
below.

Cheers,
Alex

>>
>> Was all of that churn just for this one line?
>>
>> How about simply declaring a macro
>>
>> 	#define QAT_NUMBER_OF_PM_EVENTS 8
>>
>> and then use it for the two arrays:
>>
>> 	static struct pm_status_row pm_event_rows[QAT_NUMBER_OF_PM_EVENTS] = {
>>
>> 	__u32 event_log[QAT_NUMBER_OF_PM_EVENTS];
>>
>> What am I missing?
> 
> Splitting ARRAY_SIZE() is very beneficial on its own.
> The static assert is slightly more robust for the big code then defining
> something that at some point can be missed or miscalculated. Yet we can
> survive with a macro if you thinks it's better.
> 

-----8<------------

Many xxxof_{member,field}() macros make use of the same construction to
refer to a member of a struct without needing a variable of the
structure type.

memberof(T, m) simplifies all of those, avoids possible mistakes in
repetition, adds a meaningful name to the construction, and improves
readability by avoiding too many parentheses together.

It uses a compound literal, which should optimized out by the compiler.
It's a bit simpler to read than the dereference of a casted null
pointer, due to having less parentheses in the implementation.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/container_of.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 713890c867be..5e762025c780 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -5,7 +5,9 @@
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
 
-#define typeof_member(T, m)	typeof(((T*)0)->m)
+
+#define memberof(T, member)  ((T){}.member)
+#define typeof_member(T, m)  typeof(memberof(T, m))
 
 /**
  * container_of - cast a member of a structure out to the containing structure
-- 
2.40.1

