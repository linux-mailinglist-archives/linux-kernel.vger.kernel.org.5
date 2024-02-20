Return-Path: <linux-kernel+bounces-73039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDB685BC87
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A20E2814D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C831569DE4;
	Tue, 20 Feb 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWcPBbTX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B68482FA;
	Tue, 20 Feb 2024 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433161; cv=none; b=qOd4q7dDiHts4RmZpbg4w/6X5Lk9NmhLPBCWfyKDfOWwygSzmNvoq2YOz97dEnKHIkFMKsT9172n9hUTqZYmISqQWWtuKk4qVS6yDCkbsR1ViGeDLdUP1+GHIx7qv6CqgJNLzi+Vk1jkVNE+eDnQZoC+Bv4WgVgR9MIieu8QPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433161; c=relaxed/simple;
	bh=gQul3zyPkfTKf/Ml5i7Eh8QLPr9gahhy3HMM4a1ZZlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In2CsYshM/T+gWsTxvlXM11BtmAPDPCCCjfnYOd747YjO6XKUsIBu53f2n+X94i6tfu9lYOJvNHZPFqtzsHelHbMOVIRL5obiZeEw4b2dxHlYe3HEAnEPLKZDVUP8t6j7sULfgA/H4gRJQ+JibgxR6o5YAYZUopjlKroUoY7L6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWcPBbTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D6DC433F1;
	Tue, 20 Feb 2024 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708433160;
	bh=gQul3zyPkfTKf/Ml5i7Eh8QLPr9gahhy3HMM4a1ZZlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWcPBbTXb1DAkN6KzJq3wn1GlHI+xhNHwjy1bgTzooI/4IXIUFSlAoMoGT4QfyaZm
	 Ujwg5oZiKTCwVEMTz3F5BD/UHenO999I6qmX4Ca5VX3E8V3BxNDn8Fo1f65BVQ1cuf
	 Du6DQ9saqfcUl1v6HM95gSIBD1/hIK46zFGM7JlMm2JIpkkoyXl5nMIGMPWseufNac
	 nj+1n7FC6xq9G5QqsyP0oMvJ9mtcKhA+ikFW58ZN8psKIemW3JcoCvFo+SDutH00VB
	 3EeiGvmFZ6yi2lKxVfbiplvnilUp4R1bSqLSsI3Pa49Jv8M4Fq0Y+AKBL80Lto14Qd
	 aMQWX/mSjprZA==
Date: Tue, 20 Feb 2024 12:45:56 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 8/9] net: intel: igc: Use linkmode helpers
 for EEE
Message-ID: <20240220124556.GE40273@kernel.org>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-8-71f13b7c3e60@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-keee-u32-cleanup-v4-8-71f13b7c3e60@lunn.ch>

On Sun, Feb 18, 2024 at 11:07:05AM -0600, Andrew Lunn wrote:
> Make use of the existing linkmode helpers for converting PHY EEE
> register values into links modes, now that ethtool_keee uses link
> modes, rather than u32 values.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Simon Horman <horms@kernel.org>


