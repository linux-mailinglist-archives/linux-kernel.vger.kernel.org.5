Return-Path: <linux-kernel+bounces-103982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF3C87C767
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7158E1C20E03
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAB96FDC;
	Fri, 15 Mar 2024 02:15:16 +0000 (UTC)
Received: from outbound24.service-now.com (outbound24.service-now.com [149.96.6.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7921A38CD;
	Fri, 15 Mar 2024 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.96.6.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710468916; cv=none; b=MFdmUt5qYXxX+x2SdiRZzG6r7m9ZTrVRNRByY1ZTZlEo0YiW619/VNcTlxLYVEVahHOKHOr4MuVqhQzu+tiRPy1t/h+expWw5ZTjz/yHQWuvDjHPbx2n3woTvy37igQqv73B1wM9GhAhdihEwHf99yEfmAxZ5xge24zmAtdM2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710468916; c=relaxed/simple;
	bh=uREuCvA2ZwkvR0x+FuEV8a7hjdww08RBXCd0/Pgn4HA=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=GmlgR4R7R0+3Ho6Q5fIet4NMQmPxKXGHtK8pUgOOZ+noAe5ziaIn7evQlt7SBWBdOtgYt8PMFiXx+5C9DedLtdRRWGfbBQa74D7CtbjaQhcZca+CzQzunb0LsSbPYYryw5bM24iWnuwsV8z3q9qn39w/xToi4KeRFogIN6ptTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=149.96.6.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from app142018.ycg3.service-now.com (unknown [10.248.3.236])
	by outbound24.service-now.com (Postfix) with ESMTP id 240FC401621B;
	Thu, 14 Mar 2024 19:15:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 outbound24.service-now.com 240FC401621B
Date: Thu, 14 Mar 2024 19:15:13 -0700 (PDT)
From: Red Hat Product Security <secalert@redhat.com>
Reply-To: Red Hat Product Security <secalert@redhat.com>
To: richardcochran@gmail.com, syzkaller@googlegroups.com,
	liujingfeng@qianxin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <5524723.20003.1710468913133@app142018.ycg3.service-now.com>
Subject: Re: memory leak in posix_clock_open
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_20001_18246630.1710468913133"
X-ServiceNow-Source: Notification-ec04d32213ede300196f7e276144b04e
X-ServiceNow-SysEmail-Version: 2
Precedence: bulk
Auto-Submitted: auto-generated
X-ServiceNow-Generated: true

------=_Part_20001_18246630.1710468913133
Content-Type: multipart/alternative; 
	boundary="----=_Part_20002_27205147.1710468913133"

------=_Part_20002_27205147.1710468913133
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

Hello!

INC2889741 (memory leak in posix_clock_open) has been updated.

Opened for: liujingfeng@qianxin.com
Followers: richardcochran@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller@googlegroups.com

A Guest updated your request with the following comments:

Reply from: qiang.zhang1211@gmail.com [mailto:qiang.zhang1211@gmail.com]
 >
> On Mon, Mar 11 2024 at 17:46, Z qiang wrote:
> >
> > diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
> > index 9de66bbbb3d1..71d9d8c394fa 100644
> > --- a/kernel/time/posix-clock.c
> > +++ b/kernel/time/posix-clock.c
> > @@ -137,6 +137,8 @@ static int posix_clock_open(struct inode *inode,
> > struct file *fp)
> >
> > if (!err) {
> > get_device(clk->dev);
> > + } else {
> > + kfree(pccontext);
> > }
> > out:
> > up_read(&clk->rwsem);
>
> Looks about right. Can you please send a proper patch?
 I will send a patch.
 Thanks,
Zqiang

How can I track and update my request?

To respond, reply to this email. You may also create a new email and include the request number (INC2889741) in the subject.

Thank you,
Product Security

Ref:MSG86727590
------=_Part_20002_27205147.1710468913133
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div><p style=3D"margin-top:0;margin-bottom:10px;"=
>Hello!</p><p style=3D"margin-top:0;margin-bottom:10px;">INC2889741 (memory=
 leak in posix_clock_open) has been updated.</p><p style=3D"margin-top:0;ma=
rgin-bottom:10px;">Opened for:&nbsp;liujingfeng@qianxin.com<br>Followers:&n=
bsp;richardcochran@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.ker=
nel.org, syzkaller@googlegroups.com</p></div>
<p style=3D"margin-top: 10px; margin-bottom: 10px;">A Guest updated your re=
quest with the following comments:</p>
<div style=3D"padding: 10px 0 10px 10px; background-color: ivory;"><div>Rep=
ly from: <a target=3D"_blank" href=3D"mailto:qiang.zhang1211@gmail.com" rel=
=3D"noopener noreferrer nofollow">qiang.zhang1211@gmail.com</a></div><div>&=
nbsp;</div><div>&gt;</div><div>&gt; On Mon, Mar 11 2024 at 17:46, Z qiang w=
rote:</div><div>&gt; &gt;</div><div>&gt; &gt; diff --git a/kernel/time/posi=
x-clock.c b/kernel/time/posix-clock.c</div><div>&gt; &gt; index 9de66bbbb3d=
1..71d9d8c394fa 100644</div><div>&gt; &gt; --- a/kernel/time/posix-clock.c<=
/div><div>&gt; &gt; +++ b/kernel/time/posix-clock.c</div><div>&gt; &gt; @@ =
-137,6 +137,8 @@ static int posix_clock_open(struct inode *inode,</div><div=
>&gt; &gt; struct file *fp)</div><div>&gt; &gt;</div><div>&gt; &gt;        =
 if (!err) {</div><div>&gt; &gt;                 get_device(clk-&gt;dev);</=
div><div>&gt; &gt; +       } else {</div><div>&gt; &gt; +               kfr=
ee(pccontext);</div><div>&gt; &gt;         }</div><div>&gt; &gt;  out:</div=
><div>&gt; &gt;         up_read(&amp;clk-&gt;rwsem);</div><div>&gt;</div><d=
iv>&gt; Looks about right. Can you please send a proper patch?</div><div>&n=
bsp;</div><div>I will send a patch.</div><div>&nbsp;</div><div>Thanks,</div=
><div>Zqiang</div></div>
<div><p style=3D"margin-top:20px;margin-bottom:10px;"><strong>How can I tra=
ck and update my request?</strong></p><p style=3D"margin-top:0;margin-botto=
m:10px;">To respond, reply to this email. You may also create a new email a=
nd include the request number (INC2889741) in the subject.</p></div>
<p style=3D"margin-top: 14px; margin-bottom: 0;">Thank you,<br>Product Secu=
rity</p><div>&nbsp;</div><div style=3D"display:inline">Ref:MSG86727590</div=
></body></html>
------=_Part_20002_27205147.1710468913133--

------=_Part_20001_18246630.1710468913133--

