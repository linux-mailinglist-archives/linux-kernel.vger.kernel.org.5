Return-Path: <linux-kernel+bounces-166539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842608B9C0B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2AD1F22314
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE3813C693;
	Thu,  2 May 2024 14:08:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7808C8F3;
	Thu,  2 May 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714658911; cv=none; b=SsV3ghMZg/2b/T5uAwinjN7QDPyQasztNJEKEkPm6nGOLor+OGbEevtAFnGfj0/rGb160ObBVOPFKAnF3kmhznyT26I1VzJstL9n2kW5bmWxEgL+DoBbVW/VkJLRtLuTvYTH4/HWb8LqPq6qz+svlEZatOjw6v+80NE1enBVNNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714658911; c=relaxed/simple;
	bh=XuMKQ2Qkm26WTw4+HWU8N2CzQg4t42/Hg1SnHVp9fLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ib6D5tVcIpSV5VOpNFXGF+0Pgq/I85LXnQ+3PZjcpUNKMdy+n1A+NDZ1tT+dbNreB+rYjPr2t57VHdfjt5brQAktJAaYhW7j664DyHhVseGku6in3Vs1ng83y6LxUZKSw4uNtmToVAty3tulqRGvW5Y+sjVOPGeDggPfDs0EgtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EBCC113CC;
	Thu,  2 May 2024 14:08:28 +0000 (UTC)
Date: Thu, 2 May 2024 10:09:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Tze-nan Wu (=?UTF-8?B?5ZCz5r6k5Y2X?=)" <Tze-nan.Wu@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "Cheng-Jui Wang (=?UTF-8?B?546L5q2j552/?=)" <Cheng-Jui.Wang@mediatek.com>,
 wsd_upstream <wsd_upstream@mediatek.com>, "Bobule Chang (=?UTF-8?B?5by1?=
 =?UTF-8?B?5byY576p?=)" <bobule.chang@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "mhiramat@kernel.org"
 <mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Fix uaf issue in tracing_open_file_tr
Message-ID: <20240502100914.33d6aa83@gandalf.local.home>
In-Reply-To: <aac0a4cc0a12fc9593ab7de6c34836757e6814f3.camel@mediatek.com>
References: <20240426073410.17154-1-Tze-nan.Wu@mediatek.com>
	<20240428202837.0cabca17@rorschach.local.home>
	<20240429144626.7d868ad3@gandalf.local.home>
	<661f101456506db945ccbd94700a0f47b95f91e5.camel@mediatek.com>
	<20240501235044.12fa3297@gandalf.local.home>
	<aac0a4cc0a12fc9593ab7de6c34836757e6814f3.camel@mediatek.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2 May 2024 06:49:18 +0000
Tze-nan Wu (=E5=90=B3=E6=BE=A4=E5=8D=97) <Tze-nan.Wu@mediatek.com> wrote:

> Good news, this patch works, the test has passed, no more Kasan report
> in my environment.

Great to hear!

>=20
> my environment:
>  arm64 + kasan + swtag based kasan + kernel-6.6.18
>=20
> Really appreciate, and learn a lot from the patch.

Can I add:

Tested-by: Tze-nan Wu (=E5=90=B3=E6=BE=A4=E5=8D=97) <Tze-nan.Wu@mediatek.co=
m>

?

-- Steve

