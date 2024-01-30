Return-Path: <linux-kernel+bounces-45336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA74842EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 444A3B21567
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F45E78B55;
	Tue, 30 Jan 2024 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LC6RDpv5"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F90762C7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706650594; cv=none; b=fQoktHHPpGL6k42hMQ2sKiM7fB5sdvvNMakXIsKzRaubXMqk03wP7p4nm0nwWwUuHx4f+Cn3VaHMF7HbkdBpc+mzhP1GM/D5MP5Mb0t3Cin70Iw2G4ohGFbnoG5Tk4Xi6pR9cp9n1TtvMISipVf1TCqRSTsrlEsddsLByIXxKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706650594; c=relaxed/simple;
	bh=Yw5Gqmr8Z8jqHG32kk+kikuaKYDOk1WB4PO3rY5HdM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVDqnzOchEZqV5lKIKPKT0cMb3iLzA2dtYj+u3bTGk+BjrwbfZ4hpriPa3TnijMcEnzOa+GSA6FCHOB1beMtdt2reUP0TaPydYbsJ01Ma2Ls4LF6Y8aTza+SNTxeWUUVAnliPpYnIOoet8vzrWo8yNqX7gs3aj9YQ0GKP08ujsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LC6RDpv5; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511206d1c89so1008393e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706650590; x=1707255390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=poQiwWHTggbwboPucRWxNk69pRsy13qZywqxkH5Fd3Q=;
        b=LC6RDpv5Gxce7Hl3XdPYuR0X0NZbX44V/B9IWiSIBWF/agWpe3MLgmD1iTbjuCOWYG
         Y1A+WhtD28XUzl0R6sQnlRaxYfbl5R/B1Ejxt2RAAuST10pB2kpohUpzsd73XTIfpUr8
         yA2Q/0AM4ZW1lQKFKDQLQTfzqRXAVfPEvdGzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706650590; x=1707255390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poQiwWHTggbwboPucRWxNk69pRsy13qZywqxkH5Fd3Q=;
        b=l/NMOMSDnL1PicsrM8kpK7muaT4vI/ZXAT2Q7hA8kt2tvexZ41I4rTeexHAc3Iq7wA
         qRezFJZaKvU5ia3hgq/FB79vlzvpozavhFa5uAoScBDwpQfecGaefX9XnqQO7Oxrj6dk
         qyTrCo2XwPOeZGAHxesgPUZd2uEIHhvz570USXazJf7gtlksTgb8VDNeN26eNf69Q13U
         zwkpjM9JE2A2hJJm44IA73F7J/HE6g/TTUaEU5ct/W0b7LmRGIln6LkPLo62RtUnUo2n
         DEcib42tCEndzyXmmxem7sltgvN0gg+SFb0k3m4hnj8x2FgMKUFWjVmKb2ryet5Bzm1v
         Wbkw==
X-Gm-Message-State: AOJu0YzdmcsdiU20KgQJIq7cQCN8MdVit6olMjurzrC1eFVPLT6M3Fz1
	8tDUOFEtPn/XVeabL1mGUHU7CpqBeN4S6QqfXLIXIOgcb86y9RFJEYEvZxgtKzsmHfqeS8N+Zy7
	30rz3rw==
X-Google-Smtp-Source: AGHT+IFUFSs+5gi9iTPPYGwDx0yO+4NUWYFuwt5JyfYSJdWGKyLNAdc1+gdEXrYDc7/2sLyl3Pk44g==
X-Received: by 2002:a05:6512:1194:b0:511:f63:142d with SMTP id g20-20020a056512119400b005110f63142dmr5482687lfr.29.1706650590245;
        Tue, 30 Jan 2024 13:36:30 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709060b4200b00a35ed4fd4cesm1925706ejg.115.2024.01.30.13.36.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 13:36:29 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so3944759a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:36:29 -0800 (PST)
X-Received: by 2002:a05:6402:278d:b0:55e:d46b:7d82 with SMTP id
 b13-20020a056402278d00b0055ed46b7d82mr6496982ede.28.1706650589312; Tue, 30
 Jan 2024 13:36:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-6-torvalds@linux-foundation.org> <20240130162512.312eb446@gandalf.local.home>
In-Reply-To: <20240130162512.312eb446@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 13:36:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrt4uUzxkboZtHOHkNbNBg9Hv4XAFTaNLTrpyq-VctyA@mail.gmail.com>
Message-ID: <CAHk-=wgrt4uUzxkboZtHOHkNbNBg9Hv4XAFTaNLTrpyq-VctyA@mail.gmail.com>
Subject: Re: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate function
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 13:25, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I actually find the dentry's sticking around when their ref counts go to
> zero a feature. Tracing applications will open and close the eventfs files
> many times. If the dentry were to be deleted on every close, it would need
> to be create over again in short spurts.

Sure. I think this is literally a tuning thing, and we'll see if
anybody ever says "the dentry cache grows too much with tracefs".

               Linus

