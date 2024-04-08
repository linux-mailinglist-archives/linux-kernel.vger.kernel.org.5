Return-Path: <linux-kernel+bounces-134800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BA989B725
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BE2281459
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0835B79E0;
	Mon,  8 Apr 2024 05:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="l13nWhqg"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8E7470;
	Mon,  8 Apr 2024 05:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712554145; cv=none; b=V31E1x9vSe8n1/G0T+LtAA1TzV4MO5eDBgkxdMSPdye/JfIIy+UcRroX/WVXtkN7eAu2pT2yNDgDjwKbuHxLqDo0JC22zteE5pPdOijoi+6aFrT3HHYaPOfFTRzJaqsI84BT0smX4by39fodNDRwUVhJYO1z6sqIuZjFIyuetWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712554145; c=relaxed/simple;
	bh=ZF1G4XF5SCvY/yTknXLGx7mlRuPVMOp7KyBQ2VsEMyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NY1XgljzU521bRCPS4wPB3TaYjwwmqOR/6S+Yj1Q8anJ1+MOQPTbA8pQ+2g/V+OLCT07k8MC+I4ldc8xzeH18gCFFmu2z5Jq6eGSXS+0ZQF0omWwq8f7O+RsBPnEk3xigxNeIF3Wy6DyyEzo/+BYX5NNTSdqDzwUVevdXes4f04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=l13nWhqg; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712554141;
	bh=YaJc4hAKyVAyUGlKeEz26A8dZKKd75WpuyJPiLKVz94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=l13nWhqgc3bRToxvUFycvA7lVA9dBc3YPCNj2uqG/l/kDCIG2e8Sb6jGQgeFivQoH
	 EFe110IQLmfEBjxFOAcViyBp1+B4Rq0QeY99r7Hlyx8uJovPEugC4WvRf7DAwdYiD+
	 gpHhY1ZBM8eXOfUGKGI5F9zyy4e+7qPj/EEI+9vf05fAgW+a8ZZHvRFVXpvfLfRB6M
	 YihltItPcWL16DBjvylW6uTPJGnokpeFH2JYmtGRLH0wdCpMuTh0jjnhVT6bh2U9EP
	 y+VrneMNgn34p/RJM3GY5JwegnbTV3aE9wI9CDHalYsEVkziNm8l3icev1KfmDhnna
	 bygEnbD15vrPA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VCd1T2x73z4wxt;
	Mon,  8 Apr 2024 15:29:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Finn Thain <fthain@linux-m68k.org>, Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] serial/pmac_zilog: Remove flawed mitigation for rx irq
 flood
In-Reply-To: <4bddf8ec-97f1-07f6-9c0a-523c102c0a1b@linux-m68k.org>
References: <dda2187e128bfaaf092351812e4538e2e41c17f6.1711599093.git.fthain@linux-m68k.org>
 <Zg3YZN-QupyVaTPm@surfacebook.localdomain>
 <8f234f26-d5e3-66ed-ab0c-86d3c9852b4a@linux-m68k.org>
 <CAHp75VcxLez_Nm0N8=gpWd7SKGd9JF2QXEOOB_gvX3ZtTzj6HQ@mail.gmail.com>
 <87y19s7bk6.fsf@mail.lhotse>
 <4bddf8ec-97f1-07f6-9c0a-523c102c0a1b@linux-m68k.org>
Date: Mon, 08 Apr 2024 15:29:00 +1000
Message-ID: <87v84sbexv.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Finn Thain <fthain@linux-m68k.org> writes:
> On Fri, 5 Apr 2024, Michael Ellerman wrote:
>> >> > > ---
>> >> > (here is a good location for Cc:)
>> >>
>> >> Documentation/process/submitting-patches.rst indicats that it should 
>> >> be above the "---" separator together with Acked-by etc. Has this 
>> >> convention changed recently?
>> 
>> The docs don't really say where to put the Cc: tags, although they are 
>> mentioned along with other tags which clearly are intended to go above 
>> the separator.
>
> I see no ambiguity there. What's the point of copying the message headers 
> into the message body unless it was intended that they form part of the 
> commit log?

In many cases I think it's the reverse. The Cc headers are in the commit
log *so that* git-send-email will add them to the Cc list when the patch
is sent.

In that case they can sit below the separator and still function.

IMO there is no value in having them in the commit log. The fact that
someone was Cc'ed on a patch 10 years ago is not interesting. If it ever
was interesting, for some forensic purpose, the mail archives would be
the place to look anyway.

>> > I see, I will prepare a patch to discuss this aspect.
>> 
>> FYI there was a discussion about this several years ago, where at least 
>> some maintainers agreed that Cc: tags don't add much value and are 
>> better placed below the --- separator.
>> 
>
> Maintainers who merge patches almost always add tags. And they can use the 
> Cc tags from the message headers if they wish to. Or they can omit them or 
> remove them. I don't mind. And I'd be happy to resubmit the patch with 
> different tags if that's what is needed by the workflow used by Jiri Slaby 
> or Greg Kroah-Hartman.

Many maintainers won't drop Cc: tags if they are there in the submitted
patch. So I agree with Andy that we should encourage folks not to add
them in the first place.

But that's getting very off topic for your submission :)

cheers

