Return-Path: <linux-kernel+bounces-64740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F7854226
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75119B2688B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA343C121;
	Wed, 14 Feb 2024 04:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PuZiel8+"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB35711709
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707886483; cv=none; b=Q/vwXzbWVxe5gUmksNEUWu4wAxlH57pbfgdm4Yb3pfs6DKzsMNoEGMOQYYDhFi7un70Uias2ShIfDFWYXOUz7ZGtCua30jsrW4LJU2kp0aL6iNSgWvuUsX/pKOzdlm74KncVFsqOq91LqSg3tqJD5h458Tc9AtmFBfT/d6+IJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707886483; c=relaxed/simple;
	bh=LBou+XLQ8QDVF7i9zNrb0c+TC2HDLKGD9kRdzvqDd8M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BviUaiLw9UHSSA+L67UDA2tIuitYCCvVl2xolN63fzOHwL5dSRIzqTBrQi3bELoH0DV4n/AJ2EJMTYgZ6qG2y1osc2LbAjPk630g46gWLjYPttw/ZKtR509zqi+XmcLU0u5CGpT1VXSEiY2mSHeLTY19I0e3eejJeKk3lMgN3bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PuZiel8+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc74645bfa8so2588486276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707886481; x=1708491281; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FAs57lgcOMUxLgf079L8itwe0kfFXp2CsT7fDYu4PDI=;
        b=PuZiel8+TVj6wama+WrB9HM90X5Z/P77Cp0XHMEPoUS3FzSAP487pn1JBAe+Qbk7q9
         AGqiX7uvF4qt2aaFpZ0Ygyg1GHJh8Z95b9gsnsBazYHW+RKr9I0a3SDrkavJcnIsQGb3
         l/h3oP5JUoFEShkEp1/hb5ZxLU2dIGbqS/+SOrfFscREVyJkzTncK89zcUc6g91kVLG/
         gzdPcZP0s+pgQRv33pZJlj1poghUMHsvFrA6+D8haXRsbI3tTop66F9QVaqhQMyMadi5
         hCP0pHkOgOf8Z67zYXDLVvbYCYhdwQxvHDOk2FeC85JElX0aWSrojrciAXtb4ttsk8Xw
         IbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707886481; x=1708491281;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAs57lgcOMUxLgf079L8itwe0kfFXp2CsT7fDYu4PDI=;
        b=nygAXT44abcE8hFlh2liUVMFC3DBu53SGhPv3gFA+LQtz7MWnw9U5QuYerSqKZfTwl
         mueVjv6JOwkkgA24V6bmiTBwTd0qrSiDxPeGLW3CAovz97JyFQpxckrkxfx6jdml11gA
         827NX3q6GC7RWkKXkewc3ui0xEA2V3CHFAOCUNVRhRG+oKjEUZ0K+fgoIayd4Lp2ZY8q
         QvZmhWTcimP3usFmMIyY1i1XOMZUL40kf9STA6A0QyyIVlppERRecYPDuQeFOSmrbLxk
         YLsvnqhL3v+gR/hD+lOmkF7alQ7fswOpA2YDJe9pBJde5ann1i5d7YIg9gJp5TzgdvoE
         awdA==
X-Forwarded-Encrypted: i=1; AJvYcCV2n6CD3kEneuMf5oIjBx7FwKdXRXgB2phowd0hDqB0UfPIW7fbq/L9uadAClwr+IIw36jfH+scy9cKLlRJ8m3QnwnGWm52s3ejfs6H
X-Gm-Message-State: AOJu0Yx+5zS9C4J7lD99ygvCE3ySXhXbdlBnzKrsGMTsGSmXa14Pd6Kt
	fnI/GTrnr0dOMaDQwlPtSbLw+TlBQ6sNwcc0euwJMWe4d9gvYHMmQrG4n7jO1XPmnHcSdZmg3Wc
	WS9NTvA==
X-Google-Smtp-Source: AGHT+IFpwgld5BYgEW1Kl/VAFXVUauMsroX4LSe1K6ry/SOqA3PEmypBd2ntS4b9iIcZUKdQtHBwgISl4ugR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1102:b0:dc2:5456:d9ac with SMTP
 id o2-20020a056902110200b00dc25456d9acmr50401ybu.5.1707886480735; Tue, 13 Feb
 2024 20:54:40 -0800 (PST)
Date: Tue, 13 Feb 2024 20:53:52 -0800
In-Reply-To: <20240214045356.748330-1-irogers@google.com>
Message-Id: <20240214045356.748330-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214045356.748330-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v4 4/8] tools subcmd: Add a no exec function call option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Tools like perf fork tests in case they crash, but they don't want to
exec a full binary. Add an option to call a function rather than do an
exec. The child process exits with the result of the function call and
is passed the struct of the run_command, things like container_of can
then allow the child process function to determine additional
arguments.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c | 2 ++
 tools/lib/subcmd/run-command.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 5cdac2162532..d435eb42354b 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -122,6 +122,8 @@ int start_command(struct child_process *cmd)
 		}
 		if (cmd->preexec_cb)
 			cmd->preexec_cb();
+		if (cmd->no_exec_cmd)
+			exit(cmd->no_exec_cmd(cmd));
 		if (cmd->exec_cmd) {
 			execv_cmd(cmd->argv);
 		} else {
diff --git a/tools/lib/subcmd/run-command.h b/tools/lib/subcmd/run-command.h
index 17d969c6add3..d794138a797f 100644
--- a/tools/lib/subcmd/run-command.h
+++ b/tools/lib/subcmd/run-command.h
@@ -47,6 +47,8 @@ struct child_process {
 	unsigned exec_cmd:1; /* if this is to be external sub-command */
 	unsigned stdout_to_stderr:1;
 	void (*preexec_cb)(void);
+	 /* If set, call function in child rather than doing an exec. */
+	int (*no_exec_cmd)(struct child_process *process);
 };
 
 int start_command(struct child_process *);
-- 
2.43.0.687.g38aa6559b0-goog


