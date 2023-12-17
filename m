Return-Path: <linux-kernel+bounces-2654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D155815FFF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DED9B226FB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA8B44C7D;
	Sun, 17 Dec 2023 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7W+Fmmv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43E3527E;
	Sun, 17 Dec 2023 14:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B16EC433C7;
	Sun, 17 Dec 2023 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702824710;
	bh=tSXw9ChvDbqIMksdrXNze74A2Mrytz6S/DjjMQfphBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q7W+Fmmv2PwpqSJwTfCZrr+oRU3BVS0wIW5WiL4odXzyWJS2GdttebAg8yXUnhoUm
	 iUGUKL34z7fTMs7ZE2Vie3cKbq6Uic5V/PNIRkE0l494mNopAVTvvniudBMNFvkzLq
	 U58FI1+oR8nwTSYhQsNC6q0rpdZR0/y5Tb5A5eDK2O9/bC9uHxwI86dMcRWSO/V0TA
	 2TuSk0yP1ixnC7JghANS3nr3+fo60LVgO/7FYL+Ji47eRJqf2/HtdV5bMQUKEXW2tn
	 jZz9e+2LCRSlegnIBvDj5VHJINvbM6yljMc0To09TJY/6sicvrfn7uz7HCWAB8Pdbm
	 umzDzzzqNANsQ==
Date: Sun, 17 Dec 2023 14:51:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
 dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, paul.cercueil@analog.com,
 Michael.Hennerich@analog.com, lars@metafoo.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dan.carpenter@linaro.org, dlechner@baylibre.com,
 marcelo.schmitt1@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/15] scripts: checkpatch: Add __aligned to the list
 of attribute notes
Message-ID: <20231217145132.6aac2d42@jic23-huawei>
In-Reply-To: <59d9ac4e1f7475f51672222af1fc90d7ec23b5da.camel@perches.com>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
	<1c5c93ecbd8c46a338b22a4ef52e51648e333c01.1702746240.git.marcelo.schmitt1@gmail.com>
	<59d9ac4e1f7475f51672222af1fc90d7ec23b5da.camel@perches.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 10:07:24 -0800
Joe Perches <joe@perches.com> wrote:

> On Sat, 2023-12-16 at 14:45 -0300, Marcelo Schmitt wrote:
> > Checkpatch presumes attributes marked with __aligned(alignment) are part
> > of a function declaration and throws a warning stating that those
> > compiler attributes should have an identifier name which is not correct.
> > Add __aligned compiler attributes to the list of attribute notes
> > so they don't cause warnings anymore.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Any expression that evaluates to an integer that is a power of 2 can be
> > within __aligned parenthesis.
> > I can't see how we could use a regex to check code meets such constraint (if possible).  
> 
> You can't because if a #define is used for the alignment
> value it is not necessarily available to a patch fragment
> or even a file if the #define is in an #include.
> 
> > Some additional exotic uses of __aligned are:
> > drivers/net/wireless/quantenna/qtnfmac/bus.h:72:   char bus_priv[] __aligned(sizeof(void *));
> > include/linux/netdevice.h:225:} __aligned(4 * sizeof(unsigned long));   
> 
> Right, then there are random uses like:
> 
> drivers/firmware/qcom/qcom_qseecom_uefisecapp.c:		size_t __aligned;						\
> drivers/firmware/qcom/qcom_qseecom_uefisecapp.c:			*__offset = __aligned;					\
> 
> so there's always some false positive/negative issue
> with checkpatch.
> 
> Anyway:
> 
> Acked-by: Joe Perches <joe@perches.com>
Given this should cut down on false postives I've picked this one up now.

Applied to the togreg branch of iio.git and pushed out briefly as testing to
see what blows up.

I'll see if I can pick up some more parts of this series to avoid us going round
again with quite so many patches.


Jonathan

> 
> > 
> > The regex
> > 			__aligned\s*\(.*\)
> > seems to match all use cases. 
> > 
> > We might not catch invalid arguments to __aligned, but it looks like making
> > checkpath confidently report those wouldn't be feasible anyway.
> > 
> > The patch that would trigger the mentioned warning in now
> > patch number 13 (iio: adc: Add support for AD7091R-8).
> > 
> >  scripts/checkpatch.pl | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 25fdb7fda112..d56c98146da3 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -512,6 +512,7 @@ our $Attribute	= qr{
> >  			__ro_after_init|
> >  			__kprobes|
> >  			$InitAttribute|
> > +			__aligned\s*\(.*\)|
> >  			____cacheline_aligned|
> >  			____cacheline_aligned_in_smp|
> >  			____cacheline_internodealigned_in_smp|  
> 
> 


