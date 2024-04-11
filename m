Return-Path: <linux-kernel+bounces-141115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0B18A1AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319C4B2502B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80A91E7934;
	Thu, 11 Apr 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K2jBXDJZ"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99C11E6F5F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850061; cv=none; b=fKKc1f90ZG9AJxdn6paR1oFWxKZsjK9K4jucvnJLgpw0QouexrEZ5tnSCtccGoXk4T0omUlQacoWWX5XHivq+b4g1Zue9Piet2vWpIU7tBzPu+Yr/hFk5fVcjfVPabHIC58ZBCRr0bqzYZv6pzfslkZDjFLriSpst45TJ6a6RqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850061; c=relaxed/simple;
	bh=20UuiQFkTockG+yyYjHc4F13je0ENmFxiz4QhWzCdQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1oEll6g/PX2/s1HgQdjqzv+DXZ5jJ3eFktFybAcceLhcnHPIhcSNIm+1f0UkNSBVxvgIF3obbOka92QtCoUnZCttaZrrNyonxD6gmZ/6Bn4z7LZX8Z1YFDusK0/jDJ6oTiRDMQbfOqgQvi0GEpr5p6n0mp3hhHIkAHOMJJ9Qr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K2jBXDJZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a68a2b3747so313048a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712850059; x=1713454859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNCBXKOK5vc3YGKFYUbQmuJn7ivy3cDWCe8OlWYsEZM=;
        b=K2jBXDJZ7wjvKfKnwiMLofu6RwQ6rusISxBzPJ5lI3R7EyiNkROirQre/eI+PorQXO
         auLgTDXyOBcC9CduWzqhBTHI/2vifhzkGkIvUd2cOrHFB5gvqa1yQ2FWoL8cu7U0n5bJ
         uIFH8weIUJsHtaLPXOzo0KdSu8coM3QSMMfrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850059; x=1713454859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNCBXKOK5vc3YGKFYUbQmuJn7ivy3cDWCe8OlWYsEZM=;
        b=pTPOcMiqGdUyLDRdkRjpGEB4/i9iPvmi9bkqG+7neYS7OIsN5lLZnPq0/YVEENcoDG
         Fk78tSULZWq1thPwK0h2swlvLpLYB7ZwI7SLjFMSSItZrybYZ6e8WPqnJGlYhZneDAIb
         7a/8ZVcAkQyPrIGJokl1o1T5nnAfFB3WO6r27AEWxJ5G9KDTthNjkFGUXJ4M7c0PWjX+
         hUxkNNl1WDokp4GoqKWd4GBmbsHYdZ0Bq1HkFpGRr9HVBqBXuDkNPLObOD4T4hQOhAX9
         0iq0an+d9lAb2/J89WJoz6jl1EzZrn2P8iFc559JHkHEmZ+Sf9ZoT7r5wKxNXoa0337P
         DhwA==
X-Forwarded-Encrypted: i=1; AJvYcCXOozmBy/BWN6EY0wBiT92+pMeyV2LMtc34U4RLh3WVIhlb7tbjsWej2yOwEcDaIw3BQTDBCtVCwKEpZtIQCAKwt1OTZaeQkM+3uMGG
X-Gm-Message-State: AOJu0YxB+WG87Jke+h9t3iFVCJDq7YSXFQHmrqNdkr+E3Ohzj0Wa8TOv
	TpM+MCIC3pqxMJ66EvV28XwQVGeDtEbHD3X1KLi819t05duuQ9lsf1EWvWHPVQ==
X-Google-Smtp-Source: AGHT+IH9jxm0Fb4/9rDpVIPFtRTSYrpVWRroIqBhY1mn62exKNoGoLU12zMbf7I0bbrEMi3h9K0kNg==
X-Received: by 2002:a17:90a:f3c5:b0:2a5:7e31:5030 with SMTP id ha5-20020a17090af3c500b002a57e315030mr5833139pjb.15.1712850058943;
        Thu, 11 Apr 2024 08:40:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gk16-20020a17090b119000b002a42d247a93sm1266081pjb.36.2024.04.11.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:58 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] tracing: Add sched_prepare_exec tracepoint
Date: Thu, 11 Apr 2024 08:40:51 -0700
Message-Id: <171285004930.3255679.4082124903503205236.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411102158.1272267-1-elver@google.com>
References: <20240411102158.1272267-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 12:20:57 +0200, Marco Elver wrote:
> Add "sched_prepare_exec" tracepoint, which is run right after the point
> of no return but before the current task assumes its new exec identity.
> 
> Unlike the tracepoint "sched_process_exec", the "sched_prepare_exec"
> tracepoint runs before flushing the old exec, i.e. while the task still
> has the original state (such as original MM), but when the new exec
> either succeeds or crashes (but never returns to the original exec).
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] tracing: Add sched_prepare_exec tracepoint
      https://git.kernel.org/kees/c/5c5fad46e48c

Take care,

-- 
Kees Cook


