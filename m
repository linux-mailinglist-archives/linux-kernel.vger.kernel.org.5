Return-Path: <linux-kernel+bounces-50464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D546E84794A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A911C28BC0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F09985927;
	Fri,  2 Feb 2024 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWvtwAnV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B6F15E5AB;
	Fri,  2 Feb 2024 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900910; cv=none; b=X2LFy8ycakO9CpHZq5EH4ntJdak9zsntD/XYH5WhGKQMhdJAY9v22EdXYMiREZhPn9VIjJoeGQRcBb5DyMhq+39lwGqEQjr1bj4t73nk6wurofA3i37A0xd+FLzBwHfQE8qddwN16VbHvIRQc9Qd/JRklfvncrtJmIjz5aXk9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900910; c=relaxed/simple;
	bh=5Ssa+lLvBUPG2zQEq0LY02kbRVg4r+2MDZSOjVXKVEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyghZnCMw2waGqcVYnC2v839+VxH7VTkDuuJm2gocnC0CmzyfPRp/JvpLZXkpje7wSWUST+PNQAP2WXo8JhC2Fl4ru8QRoqTUInLWZtb7rdY1rw13n8JAy4/QZSPqVhETO0+rd+I99jnTRyAITBpNwV5IhGgOBW/MuclHlFyPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWvtwAnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21D9C433C7;
	Fri,  2 Feb 2024 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900910;
	bh=5Ssa+lLvBUPG2zQEq0LY02kbRVg4r+2MDZSOjVXKVEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YWvtwAnVEkdP/ehPBbSnHBrcr5/OPcOrjBxynRhPerMOvucf/sHCi/OUY2o/pT72y
	 C4YOxX/Sqeg+w4IPOPTf8e+dsR6pwEVvlo8DQYgHjYOo5FS8i+H3GsR4WzppRrDSMl
	 fW+uxjmHRls5RpoS/alc5EqJQgE4uyLK3uE1f19kPTHjaR15rj9XrtcHOnQR+Ll88h
	 ot+Tswq2BfgkmpUp8WEiWvvZ0waKqBdpYdNh/ghRw3o+qbpbFo39cbtJ+2VDT2PLiL
	 rNr8IQfNAqZ67twk/xJFrAM89QdmhzavFoYKTVNHOLazeR/yv4LoVpFUYdkQ9xgl9G
	 PGM7PVFvC/e/w==
Date: Fri, 2 Feb 2024 11:08:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chris Leech <cleech@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nilesh Javali
 <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>, John Meneghini
 <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>, Mike Christie
 <michael.christie@oracle.com>, Hannes Reinecke <hare@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v5 2/4] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <20240202110828.7ffb050d@kernel.org>
In-Reply-To: <20240201233400.3394996-3-cleech@redhat.com>
References: <20240201233400.3394996-1-cleech@redhat.com>
	<20240201233400.3394996-3-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 15:33:58 -0800 Chris Leech wrote:
>  drivers/net/ethernet/broadcom/bnx2.c          |  1 +
>  .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  2 ++
>  drivers/net/ethernet/broadcom/cnic.c          | 25 +++++++++++++------
>  drivers/net/ethernet/broadcom/cnic.h          |  1 +
>  drivers/net/ethernet/broadcom/cnic_if.h       |  1 +

Ugh, we're implicated in this :(

Acked-by: Jakub Kicinski <kuba@kernel.org>

