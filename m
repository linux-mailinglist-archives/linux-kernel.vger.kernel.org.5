Return-Path: <linux-kernel+bounces-96457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56359875C6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3DE1F21D2E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B298D2C1A6;
	Fri,  8 Mar 2024 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OTvPK80o"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B52C1A7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709865952; cv=none; b=ACV1rKpoNTrKNzwn+v17qz9C9YE3sUMLRp3ZfPzpFsI/0MqiUOlEaxyvFZaqxigG9/CM4fLl6xPW2gENVRyGyLtQMbV+hSqhQf70zdl9u/Z5EIZyWOOMiIllLLz5TepCfmxZ/Lub1GnfSDZVCZ06R7AZx9O8x1kSF87shuPoOiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709865952; c=relaxed/simple;
	bh=W5jnX+bgKVpgCXJLnqW/MWwdx7iLA8EDehVPIN+x1PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hb1lL3+o/b1xC3UecAbRri6QDiVmMpTkmW20FdtxnuCQ96dZrTFL1oFwoI+uQgId4qgaMbwz2sLWCiewVq1zDm+D/qv6OE1Cpz/xARu9V4ttq+xPLVroX722TuEzkamBaIRERCuTYOSveVW0cWDlSssnwsMeBvFJ8Pb7Yl41/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OTvPK80o; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-6e6277f72d8so1259189b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 18:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709865950; x=1710470750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2bZO0fGsdGUR3z5kE6H/Hbx7vevj24u/qPVhihb39I=;
        b=OTvPK80oNGhj0mq/o+hdmPmmytRwnTsqS7e4aSaf7mjpa2yHJevU5cVz/VpzvPD6jo
         PbitksuxGdYHQnzw0+K3zhjYu6Hemx8vEueLymAK2GMWbL20UDrXXXUbVPz7hOFiFogg
         iBFLMn5zThv28PTKzL4H8Ky2kxKRbXRhLDVIMQJDPRfcfZfLUXBj5NNziNiiaXFLIlZ/
         jXQFbOde7p86ZvEdXidKGB28zvAYDQoqX2XUhJDJ/+eu7DGvv2+/hNi3sh1d3Dj2rfa8
         mQziUiPZ+3Vl7TV9I58XsedOmjobwO/WeKu1VWjijp07TAuyidaBiv+HysT7+f+wBOD1
         9heA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709865950; x=1710470750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2bZO0fGsdGUR3z5kE6H/Hbx7vevj24u/qPVhihb39I=;
        b=BCLuQs0RD3ZH4uwLdZQrDJNRBUZjlU8UojNu9OShRjMxgO6iQ2/bWuMU24wM4PJ/SP
         uAAZRp1s4IlQ9cNnX0HoEoagu2jiknSTSs7gpu3H/ELfMm5hIdrfFn2wl5Z3Qeehhh4N
         dah1aDDtqiualJYcl8tOevNSEAAu4jWT6ibZeAPl/fs+esz8JfwnAl5WmN15dX22S+M5
         mhECUTXmH2IAqT7kn1iu+G1WwgB6x14+mEZRi/yPfysGV+NyP4BxiqV1A58qKXfo3IOj
         QYBN5byaf97isX7B2lXMhdiV3ZI/KUZTQqdSwOqntyu+zSrbpW23cOCoITuhrcIsbwa9
         TDMA==
X-Forwarded-Encrypted: i=1; AJvYcCXmhL6qBKgriKsbZNnY24BD5DNRWBaYs/Fr+xGMI+etXK3T0W658WkBXs4N4GigfrJIpUg+FV/hGg3hkuPVgWLk7o9GaC0E3va7ZVbj
X-Gm-Message-State: AOJu0YxIR6hZV6lCX2/nCWyP8rn7wACFCwhNeA88FL+UIQEEWhD7W/2q
	z07i0Aq5UJQjWOgDCzCaDAGnWamk/OzfHFUNyyxANXXDkk6dPVONLsQ2zZQeNbA=
X-Google-Smtp-Source: AGHT+IHfqv2VeQUZO5OpjG/niCqlZWhURb4+gfcYwXm93T3wKXkIC2RK2QhIV8Pp46SWhhYaqMJS9A==
X-Received: by 2002:a05:6a20:244f:b0:1a1:7821:d012 with SMTP id t15-20020a056a20244f00b001a17821d012mr2882525pzc.26.1709865949817;
        Thu, 07 Mar 2024 18:45:49 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([2001:c10:ff04:0:1000:0:1:4])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902b10900b001d8a93fa5b1sm15244360plr.131.2024.03.07.18.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 18:45:49 -0800 (PST)
From: Rui Qi <qirui.001@bytedance.com>
To: bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	jpoimboe@redhat.com,
	peterz@infradead.org,
	mbenes@suse.cz,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	alexandre.chartre@oracle.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	yuanzhu@bytedance.com,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH v3 1/3] objtool: is_fentry_call() crashes if call has no destination
Date: Fri,  8 Mar 2024 10:45:16 +0800
Message-Id: <20240308024518.19294-2-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240308024518.19294-1-qirui.001@bytedance.com>
References: <20240308024518.19294-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandre Chartre <alexandre.chartre@oracle.com>

commit 87cf61fe848ca8ddf091548671e168f52e8a718e upstream.

Fix is_fentry_call() so that it works if a call has no destination
set (call_dest). This needs to be done in order to support intra-
function calls.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200414103618.12657-2-alexandre.chartre@oracle.com
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index dfd67243faac..71a24fd46dbd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1367,7 +1367,7 @@ static int decode_sections(struct objtool_file *file)
 
 static bool is_fentry_call(struct instruction *insn)
 {
-	if (insn->type == INSN_CALL &&
+	if (insn->type == INSN_CALL && insn->call_dest &&
 	    insn->call_dest->type == STT_NOTYPE &&
 	    !strcmp(insn->call_dest->name, "__fentry__"))
 		return true;
-- 
2.20.1


