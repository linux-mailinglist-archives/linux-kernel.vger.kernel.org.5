Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C59180EACC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjLLLtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjLLLtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:49:08 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A34FA6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:49:14 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bf7bc38c0so6315778e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702381752; x=1702986552; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qGo6VQ1GH3r8vh3FHA5skwhCVAe71E+aOwZCWSOJx4Q=;
        b=IEeG14i2r5a9V4hO9+sQnVLKuxFQjSYKnJL9Op7MROYUTI9bfrK3ZbFkhDRIqImgt6
         O/WINTT4sMALzhPl8C+a9wLDb6YrMuop4X5f3+QZtcYW+3D98gJSvrCLt78aha2bLUuZ
         Q9LF9xMT8dAT+oYb4Ql6dk97e/kG8HMDDqi0XVorSpaYmluMagWRALhu99cV2O5Q4hla
         h6nhvhhmBugEfKosyS7x7Kccg6nNj1yvCLIXsNC2gIjKsBtphOJegKu41aPfdNbq6wxU
         CkWW9Ft/x417kXkHZvBt/FRouN6XP3GI5yI4/NGxk/F+IyquoJYRbO/9HkfIPWnCVHob
         oK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702381752; x=1702986552;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGo6VQ1GH3r8vh3FHA5skwhCVAe71E+aOwZCWSOJx4Q=;
        b=dq57oo/RVZRzKvKuc079j9lHy+Dgn9SdBSPgOjfLZUo7/ZPGi4U9C2JBTzRPlI6DYp
         UTS84qcINH8l5/FMDLbZYSgcTbz3syrorZCK8yBkdu9+HYnwXR0o/LsoB5GVRpWXN2Fb
         IZSZwNXlctrbjLyinc3Ecqq4WuHumYZHKeo4eQEPwt63+xdkynvbVSLiXF1RZFV8tH8R
         rZcErRoQLYRhF7slJiN6QBfyz9tQ3AEJkDCy/giH2BDc6KE0Onkwf31+VFnp3KkfVRwa
         g4uPwnNVwUejAbYDsNVSWRUHa/XwuPJVd0SsZHSsjbB6fXe14hSkrbi7ZDkp1JdGTJ7F
         FK8g==
X-Gm-Message-State: AOJu0YxSEM+djrAnS2qd365zBibh3HBpK4ai2RWWsrru1pPoV+zFJGht
        zMlDpA04/QhAdnKYon/o+g==
X-Google-Smtp-Source: AGHT+IGbPbbFefIk1k+odfvS6l0CnYSHd5dXKAtSwwJxDsoFE3kFXefh2WlOFxIwaoXcYUnUkK8TZg==
X-Received: by 2002:ac2:4d91:0:b0:50b:ee87:eeb4 with SMTP id g17-20020ac24d91000000b0050bee87eeb4mr2859443lfe.54.1702381752342;
        Tue, 12 Dec 2023 03:49:12 -0800 (PST)
Received: from p183 ([46.53.250.155])
        by smtp.gmail.com with ESMTPSA id vs6-20020a170907a58600b00a1fa6a70b8dsm2530499ejc.133.2023.12.12.03.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:49:12 -0800 (PST)
Date:   Tue, 12 Dec 2023 14:49:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, x86@kernel.org
Subject: cast inside __pcpu_cast_1 macro
Message-ID: <c107538b-4e4a-4698-aca2-327eacdc15b2@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Brian.

You've added the following macros in

	commit 6865dc3ae93b9acb336ca48bd7b2db3446d89370
	x86/percpu: Introduce size abstraction macros

+#define __pcpu_cast_1(val) ((u8)(((unsigned long) val) & 0xff))
+#define __pcpu_cast_2(val) ((u16)(((unsigned long) val) & 0xffff))
+#define __pcpu_cast_4(val) ((u32)(((unsigned long) val) & 0xffffffff))
+#define __pcpu_cast_8(val) ((u64)(val))

They break complation if "val" is something complex like

	this_cpu_write(pcp, *x = 1);

Only __pcpu_cast_8() is correct in this regard.
"val" should be in parenthesis at least.

Is there a reason for casts to "unsigned long"?

Why not just

	#define __pcpu_cast_1(val)	((u8)(val))
