Return-Path: <linux-kernel+bounces-65054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96097854733
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539A0283248
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF61A18021;
	Wed, 14 Feb 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lDQx2/0g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F085F17543;
	Wed, 14 Feb 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906863; cv=none; b=exKmn+GqxQmuNYgWcCja2icCx1X+VisJBjwj1/NllKrqAlGyCAx5m8TH5BzqBRuFzRpQASLMkVPJDaK+uPkyXRtPh8htuh6Z7fW7TiBSWDWXit9HadqJGyhQN2ygCdC7oscDxBW4VsAEJpt1KfOuXG0Kg6On5I6oKuK3md1Ywas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906863; c=relaxed/simple;
	bh=DkS4pHSLevwnDUiaBlD8B/uLDOdKpNV1qvB47nYEqPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUd36Zh0bj7bFA0MPZIV2vC3etC2hcuh/KeaGYvES3fbiwVk8fHPFKsiec4auM9uU0X9gBp6sf5hZl9MCbQiIesyUC8umbKazBx+7ldqA1odtqugjquYOA06kRb0SM+zQpRWOmIsSznXvgHhLPFJxv22lOK4tphvnBFaxGvAx8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lDQx2/0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9952C433F1;
	Wed, 14 Feb 2024 10:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707906862;
	bh=DkS4pHSLevwnDUiaBlD8B/uLDOdKpNV1qvB47nYEqPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDQx2/0giln9bSgIWKwhm0lRPICkGgbmBs5pbsKMA3UOZqGxJHwOO/VlVAXHWqpcY
	 1Euqnq7GXzADgKEYPs9Pgz8ZbyLvBpEoLFLZJdWPpIYhru9Pi2aQwb9u0NApbuhNmi
	 a+X4ZZVFf9OAxcpZKVSsiM94KPmwTTiLYdD3E5C8=
Date: Wed, 14 Feb 2024 11:27:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 0/2] kobject: reduce uevent_sock_mutex contention
Message-ID: <2024021444-getaway-partly-e055@gregkh>
References: <20240214084829.684541-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214084829.684541-1-edumazet@google.com>

On Wed, Feb 14, 2024 at 08:48:27AM +0000, Eric Dumazet wrote:
> This series reduces the (small ?) contention over uevent_sock_mutex,
> noticed when creating/deleting many network namespaces/devices.
> 
> 1) uevent_seqnum becomes an atomic64_t
> 
> 2) Only acquire uevent_sock_mutex whenever using uevent_sock_list

Cool, any boot-time measured speedups from this?  Or is this just tiny
optimizations that you noticed doing reviews?

thanks,

greg k-h

