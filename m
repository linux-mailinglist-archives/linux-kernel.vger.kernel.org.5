Return-Path: <linux-kernel+bounces-6900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBB1819F22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5ED1C2259B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC3624B28;
	Wed, 20 Dec 2023 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnQfeIFh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C5249EC;
	Wed, 20 Dec 2023 12:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30E0C433C8;
	Wed, 20 Dec 2023 12:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703075744;
	bh=DazYu82Xc3x5ePmNeu+4DL1dZDLCKT+ifdIXMSgKMGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnQfeIFh5aMCwr1SZ7+UHbfAu//WSPbfx/AHMiIp5LDAQe0j9kMB2jiyfoJn/r7qc
	 KQtP7W3Vu4+3DwMqv0ydOECtUFfnkOX4moQ+xNZ7OfP+/efHXFnfUAUSW0UYBbd0Yr
	 TQ7upPCfIsXAcso2QFlmEbOvhpLoo92MHR/Z9ly6k/eehbLM3I2oHeHkJAB41q6tWm
	 2N/XFmv/4CPm3Sw4SmULQWICPYJ8R6b4vrSCj3SDDpAJK0FUdlPXZsk7/Ln6TTdypN
	 bX3V44zBnEcJiK8mqUfma05V2PTf99Yh59him/JeLg+LfGeJcux2CUzUnsfiTeBV0b
	 KnF66X8SZie+Q==
Date: Wed, 20 Dec 2023 13:35:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-unionfs@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Seth Forshee <sforshee@kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v2 0/3] evm: disable EVM on overlayfs
Message-ID: <20231220-komprimieren-kooperativ-cdb5e8803ce0@brauner>
References: <20231219175206.12342-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231219175206.12342-1-zohar@linux.ibm.com>

On Tue, Dec 19, 2023 at 12:52:03PM -0500, Mimi Zohar wrote:
> EVM verifies the existing 'security.evm' value, before allowing it
> to be updated.  The EVM HMAC and the original file signatures contain
> filesystem specific metadata (e.g. i_ino, i_generation and s_uuid).
> 
> This poses a challenge when transitioning from the lower backing file
> to the upper backing file.
> 
> Until a complete solution is developed, disable EVM on overlayfs.
> 
> Changelog v2:
> Addressed Amir's comments:
> - Simplified security_inode_copy_up_xattr() return.
> - Identified filesystems that don't support EVM based on a new SB_I flag.

We're wasting a flag for a single filesystem but we do have enough of
them left so I think this is ok,

Reviewed-by: Christian Brauner <brauner@kernel.org>

