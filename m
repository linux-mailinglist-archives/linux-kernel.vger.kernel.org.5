Return-Path: <linux-kernel+bounces-51776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2771848F2D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E591C20A1F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20EB22EF6;
	Sun,  4 Feb 2024 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=reisers.ca header.i=@reisers.ca header.b="KClBTr3R";
	dkim=pass (1024-bit key) header.d=reisers.ca header.i=@reisers.ca header.b="KClBTr3R"
Received: from befuddled.reisers.ca (befuddled.reisers.ca [206.248.184.127])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255C022EE5
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.248.184.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063287; cv=none; b=SuwtsXUlBkT7YHyU56TzEFIm7DzOBxEzxrImAA63hp8cM1VdgH87Yru8iiwtazHwknUWJDM6+0w+ZSOuSwWEj+ePqZ+YEYjI6bnKNb473popAX5PsQ+YZ49Iw8oT+6N6PQB+VJkjXrm5MtIjmEcy0tIVqSR0Q2w86FWoRWEQPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063287; c=relaxed/simple;
	bh=tWnu2y4zJ6KFIND6qBtnbCYUimzDqDUKamLNQO3cP9g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PIFcye+c+33Q/g4/qpTa2Q2vuss0PlBq34KAqFlCYpMDDpE2j4GGq2HCCxbo8kxZkm28bvyaZh+N6+H9lMcg8ARR+1WGl16M1ZNuGddro4CTMI+UWGUJhGQ+KEKQZCR79wRgc3Q2QXu8fkN40OqqWHR8KMDNSMKCMazZYNbg6Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reisers.ca; spf=none smtp.mailfrom=reisers.ca; dkim=pass (1024-bit key) header.d=reisers.ca header.i=@reisers.ca header.b=KClBTr3R; dkim=pass (1024-bit key) header.d=reisers.ca header.i=@reisers.ca header.b=KClBTr3R; arc=none smtp.client-ip=206.248.184.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reisers.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=reisers.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=reisers.ca;
	s=befuddled; t=1707062834;
	bh=tWnu2y4zJ6KFIND6qBtnbCYUimzDqDUKamLNQO3cP9g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KClBTr3RlOOGaORXGkA8W8w0+4zY707YIQdEz7scbfTdPfyNgVvMsmaxHFys9Xw1v
	 k7xvxY9le7yEKGGQnUnqkeyeP6BikEyn9f/foLh9A5jQMBHUKntJ5S6BA5f2UqboDG
	 7+aoMbKx1O9z2wuqv+kP5qnkSR/PemFQ1/NBkFDU=
Received: by befuddled.reisers.ca (Postfix, from userid 65534)
	id 6C7D3382537; Sun,  4 Feb 2024 11:07:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=reisers.ca;
	s=befuddled; t=1707062834;
	bh=tWnu2y4zJ6KFIND6qBtnbCYUimzDqDUKamLNQO3cP9g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KClBTr3RlOOGaORXGkA8W8w0+4zY707YIQdEz7scbfTdPfyNgVvMsmaxHFys9Xw1v
	 k7xvxY9le7yEKGGQnUnqkeyeP6BikEyn9f/foLh9A5jQMBHUKntJ5S6BA5f2UqboDG
	 7+aoMbKx1O9z2wuqv+kP5qnkSR/PemFQ1/NBkFDU=
Received: from localhost (localhost [IPv6:::1])
	by befuddled.reisers.ca (Postfix) with ESMTPS id 3BB4238251B;
	Sun,  4 Feb 2024 11:07:14 -0500 (EST)
Date: Sun, 4 Feb 2024 11:07:14 -0500 (EST)
From: Kirk Reiser <kirk@reisers.ca>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
    speakup@linux-speakup.org
Subject: Re: [PATCH] speakup: Add /dev/synthu device
In-Reply-To: <20240204155825.ditstifsbqndnce3@begin>
Message-ID: <eacaf4db-5b1e-e42e-96aa-3c803fda9180@reisers.ca>
References: <20240204155825.ditstifsbqndnce3@begin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

Samuel: Would you possibly look into passing the characters from
saychar and it's family through to the softsynu device? There is a
disconnect because espeakup/espeak-ng pronounces characters one way
and the chartab look up has a different way of saying them. I believe
passing them on is probably better although we give up the ability to
pronounce them as we'd like to hear them.

Thank you for dealing with all this stuff!

   Kirk

On Sun, 4 Feb 2024, Samuel Thibault wrote:

> /dev/synth has always been 8bit, but applications nowadays mostly
> expect to be using utf-8 encoding.  This adds /dev/synthu to be able
> to synthesize non-latin1 characters.  This however remains limited
> to 16bit unicode like the rest of speakup.  Any odd input or input
> beyond 16bit is just discarded.
>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>
> Index: linux-6.4/drivers/accessibility/speakup/devsynth.c
> ===================================================================
> --- linux-6.4.orig/drivers/accessibility/speakup/devsynth.c
> +++ linux-6.4/drivers/accessibility/speakup/devsynth.c
> @@ -7,9 +7,10 @@
> #include "speakup.h"
> #include "spk_priv.h"
>
> -static int misc_registered;
> +static int synth_registered, synthu_registered;
> static int dev_opened;
>
> +/* Latin1 version */
> static ssize_t speakup_file_write(struct file *fp, const char __user *buffer,
> 				  size_t nbytes, loff_t *ppos)
> {
> @@ -34,6 +35,97 @@ static ssize_t speakup_file_write(struct
> 	return (ssize_t)nbytes;
> }
>
> +/* UTF-8 version */
> +static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
> +				   size_t nbytes, loff_t *ppos)
> +{
> +	size_t count = nbytes, want;
> +	const char __user *ptr = buffer;
> +	size_t bytes;
> +	unsigned long flags;
> +	unsigned char buf[256];
> +	u16 ubuf[256];
> +	size_t in, in2, out;
> +
> +	if (!synth)
> +		return -ENODEV;
> +
> +	want = 1;
> +	while (count >= want) {
> +		/* Copy some UTF-8 piece from userland */
> +		bytes = min(count, sizeof(buf));
> +		if (copy_from_user(buf, ptr, bytes))
> +			return -EFAULT;
> +
> +		/* Convert to u16 */
> +		for (in = 0, out = 0; in < bytes; in++) {
> +			unsigned char c = buf[in];
> +			int nbytes = 8 - fls(c ^ 0xff);
> +			u32 value;
> +
> +			switch (nbytes) {
> +			case 8: /* 0xff */
> +			case 7: /* 0xfe */
> +			case 1: /* 0x80 */
> +				/* Invalid, drop */
> +				goto drop;
> +
> +			case 0:
> +				/* ASCII, copy */
> +				ubuf[out++] = c;
> +				continue;
> +
> +			default:
> +				/* 2..6-byte UTF-8 */
> +
> +				if (bytes - in < nbytes) {
> +					/* We don't have it all yet, stop here
> +					 * and wait for the rest
> +					 */
> +					bytes = in;
> +					want = nbytes;
> +					continue;
> +				}
> +
> +				/* First byte */
> +				value = c & ((1u << (7 - nbytes)) - 1);
> +
> +				/* Other bytes */
> +				for (in2 = 2; in2 <= nbytes; in2++) {
> +					c = buf[in + 1];
> +					if ((c & 0xc0) != 0x80)	{
> +						/* Invalid, drop the head */
> +						want = 1;
> +						goto drop;
> +					}
> +					value = (value << 6) | (c & 0x3f);
> +					in++;
> +				}
> +
> +				if (value < 0x10000)
> +					ubuf[out++] = value;
> +				want = 1;
> +				break;
> +			}
> +drop:
> +		}
> +
> +		count -= bytes;
> +		ptr += bytes;
> +
> +		/* And speak this up */
> +		if (out) {
> +			spin_lock_irqsave(&speakup_info.spinlock, flags);
> +			for (in = 0; in < out; in++)
> +				synth_buffer_add(ubuf[in]);
> +			synth_start();
> +			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +		}
> +	}
> +
> +	return (ssize_t)(nbytes - count);
> +}
> +
> static ssize_t speakup_file_read(struct file *fp, char __user *buf,
> 				 size_t nbytes, loff_t *ppos)
> {
> @@ -62,31 +154,57 @@ static const struct file_operations synt
> 	.release = speakup_file_release,
> };
>
> +static const struct file_operations synthu_fops = {
> +	.read = speakup_file_read,
> +	.write = speakup_file_writeu,
> +	.open = speakup_file_open,
> +	.release = speakup_file_release,
> +};
> +
> static struct miscdevice synth_device = {
> 	.minor = MISC_DYNAMIC_MINOR,
> 	.name = "synth",
> 	.fops = &synth_fops,
> };
>
> +static struct miscdevice synthu_device = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "synthu",
> +	.fops = &synthu_fops,
> +};
> +
> void speakup_register_devsynth(void)
> {
> -	if (misc_registered != 0)
> -		return;
> -/* zero it so if register fails, deregister will not ref invalid ptrs */
> -	if (misc_register(&synth_device)) {
> -		pr_warn("Couldn't initialize miscdevice /dev/synth.\n");
> -	} else {
> -		pr_info("initialized device: /dev/synth, node (MAJOR %d, MINOR %d)\n",
> -			MISC_MAJOR, synth_device.minor);
> -		misc_registered = 1;
> +	if (!synth_registered) {
> +		if (misc_register(&synth_device)) {
> +			pr_warn("Couldn't initialize miscdevice /dev/synth.\n");
> +		} else {
> +			pr_info("initialized device: /dev/synth, node (MAJOR %d, MINOR %d)\n",
> +				MISC_MAJOR, synth_device.minor);
> +			synth_registered = 1;
> +		}
> +	}
> +	if (!synthu_registered) {
> +		if (misc_register(&synthu_device)) {
> +			pr_warn("Couldn't initialize miscdevice /dev/synthu.\n");
> +		} else {
> +			pr_info("initialized device: /dev/synthu, node (MAJOR %d, MINOR %d)\n",
> +				MISC_MAJOR, synthu_device.minor);
> +			synthu_registered = 1;
> +		}
> 	}
> }
>
> void speakup_unregister_devsynth(void)
> {
> -	if (!misc_registered)
> -		return;
> -	pr_info("speakup: unregistering synth device /dev/synth\n");
> -	misc_deregister(&synth_device);
> -	misc_registered = 0;
> +	if (synth_registered) {
> +		pr_info("speakup: unregistering synth device /dev/synth\n");
> +		misc_deregister(&synth_device);
> +		synth_registered = 0;
> +	}
> +	if (synthu_registered) {
> +		pr_info("speakup: unregistering synth device /dev/synthu\n");
> +		misc_deregister(&synthu_device);
> +		synthu_registered = 0;
> +	}
> }
>

