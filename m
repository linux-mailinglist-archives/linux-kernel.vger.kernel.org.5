Return-Path: <linux-kernel+bounces-131796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C86898BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA38282239
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B941712B148;
	Thu,  4 Apr 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvbU4kyg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BC612AAF3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247169; cv=none; b=uoWFWJiL2Fjd1CqyWtUSaUkVDnfaQSANscHFWknCVMvQkoplZD16xU6yvkxWBHaizXKbIKQRNb5221iqceVt0eHVmaJBGnDRX2ch7qq0GVGHr8vWc5e+8b4Q7t8o8/BRAhAdAI/FAS7RMmXda3LZn3FyuD+l0mslKPFdv22dsEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247169; c=relaxed/simple;
	bh=3HSmrmrDL7YmMBwELqadS0hgYO3UwLptL2RIgXbGdgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9Z4MZAl7Wwu/irV1HuR7KlgvIV/fXAws6ek5NLg7V2GNZMzoaVQ3YiLkLaWAI+WJIl6Z/9invwt6qzV4mnx1mwB1e4WqziIEYmuXMhDyto7YK9ItXnGY6Er2BqF56rB0fSQLMSVB4uH1g89oQkLzn+uRJzqONQzaFhElY3kK8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvbU4kyg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712247166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3HSmrmrDL7YmMBwELqadS0hgYO3UwLptL2RIgXbGdgQ=;
	b=hvbU4kygzWdRCyV6ThDDhID2zabIixzdn57MRN933uw+kiI134GbB/IIJNLNYqAGrrDaCZ
	Phorys1l0fA84+I0IRBajAOcZDsy4GKzg+LsVksXmNDXLoDH+W9iHcvPNnUaxBoTNDC5C2
	A2XJc4SZ+XR6rIzEXRy13kIyTno7Ov4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-j9ymssyqOlWdOSkA-ie3Bw-1; Thu, 04 Apr 2024 12:12:44 -0400
X-MC-Unique: j9ymssyqOlWdOSkA-ie3Bw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C64885A5B9;
	Thu,  4 Apr 2024 16:12:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.21])
	by smtp.corp.redhat.com (Postfix) with SMTP id 10D51492BC6;
	Thu,  4 Apr 2024 16:12:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  4 Apr 2024 18:11:18 +0200 (CEST)
Date: Thu, 4 Apr 2024 18:11:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-ID: <20240404161108.GG7153@redhat.com>
References: <20240402093302.2416467-1-jolsa@kernel.org>
 <20240402093302.2416467-2-jolsa@kernel.org>
 <20240403100708.233575a8ac2a5bac2192d180@kernel.org>
 <Zg0lvUIB4WdRUGw_@krava>
 <20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
 <CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
 <20240404095829.ec5db177f29cd29e849169fa@kernel.org>
 <CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
 <20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 04/05, Masami Hiramatsu wrote:
>
> Can we make this syscall and uprobe behavior clearer? As you said, if
> the application use sigreturn or longjump, it may skip returns and
> shadow stack entries are left in the kernel. In such cases, can uretprobe
> detect it properly, or just crash the process (or process runs wrongly)?

Please see the comment in handle_trampoline(), it tries to detect this case.
This patch should not make any difference.

Oleg.


