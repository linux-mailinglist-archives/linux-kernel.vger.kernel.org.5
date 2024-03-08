Return-Path: <linux-kernel+bounces-97323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23B98768C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93305B21912
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548412B8B;
	Fri,  8 Mar 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx+dNemt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A8568A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916482; cv=none; b=PNrndP4OXjf9uXbHL8AulBdbrmP2mwXOadlvduopqaaGfnxuuIkP9zgIZYadPAVMn7v8I6VxHxTMejdZNT+JFPMdHOSJGigu4ekJkUP6gzbhPdwvz5bibcJYM/NCfNc5rBrfogU8E4CNtSnO2smUnr1fdHDwg/F+7FCmMUaYOyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916482; c=relaxed/simple;
	bh=qTNnCVlqYR7Tb/MCVbLKlm4DSuUtZRcZgvJGq6O7n3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adVOQKa5Vpqxt3Ic+uT5c0luqzKthdgnYkyib+vcXT+gHGBHDiTY6aSpILn0H5I17tPcuruQMfO1ukWBQ0rw8C7VyvjsNDiHDmWw9mRhE7K745BYZCPhKngDXKaiSXwYSf62a7fU/MQv3srWiNpvMyaAmT/+dEJVMfPRS8VdiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx+dNemt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4CFC433C7;
	Fri,  8 Mar 2024 16:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709916482;
	bh=qTNnCVlqYR7Tb/MCVbLKlm4DSuUtZRcZgvJGq6O7n3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wx+dNemty4zAGHkxSAUtcr89ecXisZOa1RqMDAjSG2FjQZgpxJEvJqpot23bX+WiE
	 vNQy+BDDhIver82slHVrNhwhCOrPVQyxsOVUEWPTBN+IalSLbgR8COLNiohhFXf6cX
	 8mJ4ITtXN0J1HorrlUIUOOLDxBO7CEq+uSAmFaBZNr7zEHqcPSCs9ZfsEOcYtDRs5Y
	 2wbJUp+U+avcyRLtM1wquG/345ZSqzUiG5KEnk2xRjdMmWnbOWbohaCUN6UuYE+GdI
	 bYkhz2n4cH7Qlpz19TeaCmK1SfuzoelALqluhF7GFFuN73PCh2DqMwaD6moblW0Q6J
	 ZayRiAl2SMdKw==
Date: Fri, 8 Mar 2024 09:47:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: =?utf-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag
 allocation
Message-ID: <ZetBP5YPUnJ2V4Kp@kbusch-mbp>
References: <20240308015435.100968-1-brookxu.cn@gmail.com>
 <20240308144208.GA9194@lst.de>
 <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com>
 <20240308163100.GA17078@lst.de>
 <CADtkEecyqONmjRorKOWzToH9y1SVXf3GXXvg_BHcFZ506mPWkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADtkEecyqONmjRorKOWzToH9y1SVXf3GXXvg_BHcFZ506mPWkA@mail.gmail.com>

On Sat, Mar 09, 2024 at 12:43:12AM +0800, 许春光 wrote:
> Sorry for delay to reply, I found the patch have applied just about 10
> minutes ago.
> According what you plan to do, I think as-is maybe fine, But anyway if
> need, I will
> send another patch to cleanup, thanks.

The next pull request will be late next week, so I'll back out the
commit if you want to submit something else before then. Or you can just
submit an incremental improvement against the current tree, and that's
also fine.

