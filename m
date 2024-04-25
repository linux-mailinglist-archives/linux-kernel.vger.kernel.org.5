Return-Path: <linux-kernel+bounces-159184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6908B2A63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0676A284781
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372B155742;
	Thu, 25 Apr 2024 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WOGsbgGa"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC664155734
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079149; cv=none; b=QLQHEKgn24hRe0iPC0GVrjL1P1TVUdEolotYyXp/3uge9pEnNrM7dAY0q1HMQSkcVG6oXaAQKNbcqN8r6puzD4ecbfg51mfHQCAcVH+fL2AVbAxBvBSs7V5ZImN+gLmZSYw2wFuQJZ0g4oCW25TMM+6FUgqsiVUf4LHPZyoiyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079149; c=relaxed/simple;
	bh=A38Sx4GnsalTzSk3PQhWAGWQ/Aj22CxFH+1r9rNmuwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImABRU2rba9v9P+ibdFbZ0Ej50lJ1T/ncrqoqxRCGb47c7u+2oKmsuuVWUbSC2x6xuy6jM25chBBBIthuHrBQt8M4V7V1sEkUbTAKV7jcu2dr1jZUPSioE+Irjsf7u8/flQRcBrj0vHA9tcFWBOI5v40PRKlFhdpsf7pfuzrXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WOGsbgGa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so1590618b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714079147; x=1714683947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbXTRsXcWJm5fvNdQcF21f3J3gw2jR5dxvVtlm0/fmM=;
        b=WOGsbgGaY1Pvi0AoPRgzuW1D2dGou1btPWeSAA9px9LdxMzqL7GMT7z8SieTjXWaZE
         gkgJR8vOFh7S7TQJNuhlKBTDX2zGOvn1U3+zFKqFNRpcTLDEUysbgG732lyUaKfstqBc
         lQPHcCQneaH+4EDLaPmdbpRCtiRCTQJf1aTnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714079147; x=1714683947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbXTRsXcWJm5fvNdQcF21f3J3gw2jR5dxvVtlm0/fmM=;
        b=C6xQv4KnJbKmcMggrwBuoj5lXM+GlKOW0KaXbN0gajn2bkSHekjVTs58iy/qwz+/Mu
         PYhXtyuKYoPxGxLb7OIPpcvXYwbc8GzU0urtEUKBSACSEZIWkVzzSDnEpDRTr/snqhq3
         fK8gdpUXm/64xjVOYB4Ybg+oEQTtKAUdeajVE0RJHE1IA6HMGBIG4qorbuSW85GP4hjK
         IBrp6ck0PivQt2nRvwFGAuzhU2VJ1lzvudmx9WTi7IueR5RMG8bUmmmFHFu9BClX80xO
         PtgHAYqxPav6dfcIn3Yh9fqullDDbfR3ybu+H7eZG6vBATQnJMIj4z3Gva0GbBkgFxZw
         qpaw==
X-Forwarded-Encrypted: i=1; AJvYcCWfFkbjDJ+Y2s8T7GSMDhmh1CMCSK3ORRd3Jx6VdoFP+a+w44MhlDGS0WPtteCpUj9VRMXvZU0kbTnZ2cjv/UxYjbc0EC4nTKMw8gBM
X-Gm-Message-State: AOJu0YyP2jwP6LPNnXjx9X1RHpY5nw8YJqZYIBjXpz+4ty9wAqklzc5j
	y7ovOUGEqNAoV5ZN7bagmUbPyxsTHocs0r214fDMoo30ce7OhKYcq3+BIDmsGg==
X-Google-Smtp-Source: AGHT+IE34ZdmmbLMEhF/nS05GuH5dy9nnAfbW5wawkPAOn4MYqCYoSrpwfSBL/elhAQLrdjdmbLFFw==
X-Received: by 2002:a05:6a00:2446:b0:6f0:c79f:cd7e with SMTP id d6-20020a056a00244600b006f0c79fcd7emr1364180pfj.0.1714079147153;
        Thu, 25 Apr 2024 14:05:47 -0700 (PDT)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id j22-20020a056a00235600b006ea7d877191sm13634723pfj.2.2024.04.25.14.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 14:05:46 -0700 (PDT)
From: jeffxu@chromium.org
To: aruna.ramakrishna@oracle.com
Cc: andrew.brownsword@oracle.com,
	dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	matthias.neugschwandtner@oracle.com,
	tglx@linutronix.de,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jannh@google.com,
	sroettger@google.com,
	x86@kernel.org
Subject: Re: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Date: Thu, 25 Apr 2024 21:05:40 +0000
Message-ID: <20240425210540.3265342-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
In-Reply-To: <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>
References: <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

On 3/21/24 14:56, Aruna Ramakrishna wrote:
>Enabling both the non-zero pkey (for the thread) and pkey zero (in
>userspace) will not work for us. We cannot have the alt stack writeable
>by all - the rationale here is that the code running in that thread
>(using a non-zero pkey) is untrusted and should not have access to the
>alternate signal stack (that uses pkey zero), to prevent the return
>address of a function from being changed. The expectation is that kernel
>should be able to set up the alternate signal stack and deliver the
>signal to the application even if pkey zero is explicitly disabled by
>the application. The signal handler accessibility should not be dictated
>by the PKRU value that the thread sets up.
>
We have a similar threat model that we don't want "untrusted threads" to
access altstack. I think this patch need not be restricted to the
use case of zero pkey for altstack, i.e. application can also set
non-zero pkey to altstack and expect the same.

>Solution:
>The PKRU register is managed by XSAVE, which means the sigframe contents
>must match the register contents - which is not the case here. We want
>the sigframe to contain the user-defined PKRU value (so that it is
>restored correctly from sigcontext) but the actual register must be
>reset to init_pkru so that the alt stack is accessible and the signal
>can be delivered to the application. It seems that the proper fix here
>would be to remove PKRU from the XSAVE framework and manage it
>separately, which is quite complicated. As a workaround, this patch does
>something like this:
>
>        orig_pkru = rdpkru();
>        wrpkru(init_pkru & orig_pkru);
>        xsave_to_user_sigframe();
>        put_user(pkru_sigframe_addr, orig_pkru)
>
The default PKRU of thread [1] is set as 01 (disable access) for each PKEY
from 1 to 15, and 00 (RW) for PKEY 0.

Let's use pkey 1 as an example:
The init_pkru is 01, if the thread has PKRU (orig_pkru) as 10 (disable write
but have read) then new_pkru from (init_pkru & orig_pkru) is 00, which gives
RW access to the pkey 1.

When the thread has orig_pkru as 01 (disable access) or 00 (RW), new_pkru is
unchanged from orig_pkru.

Now take pkey 0:
the init_pkru is 00, regardless what threads has, new_pkru will always be 00.

This seems to work out well for pkey 1 to 15, i.e. signal handing code in
kernel only give write access when the thread alrady has read access to the
PKEY that is used by the altstack. The threat model interesting here is to
prevent untrusted threads from writing to altstack, and read is probably less
of a problem.

Does this meet what you want? (Note the pkey 0 is different than 1-15)

Suppose someone also like to disable all access to altstack, then there is one
more place to mind: in sigreturn(), it calls restore_altstack(), and requires
read access to altstack. However, at the time, PKRU is already restored from
sigframe, so SEGV will raise (the value in sigframe doesn't have read access
to the PKEY).

Without changing sigreturn, using wrpkru(0) here might not be necessary:
the dispatch to user space works fine, only to crash at sigreturn step.

[1] defined by init_pkru_value in pkeys.c

Best regards,
-Jeff

