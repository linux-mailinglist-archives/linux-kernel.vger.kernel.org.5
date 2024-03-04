Return-Path: <linux-kernel+bounces-91036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1928708BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2BC1F23ADB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ED86168D;
	Mon,  4 Mar 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zmm1t5So"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1394C6025B;
	Mon,  4 Mar 2024 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574794; cv=none; b=foa3juXX2zOjDsSb3EhN8WnLoQz0U9xuYarUDVXpkC/9ooHsMkPTMo4cqovA3Prlab7MlW5KfG9niV1sU+uwVkcMG0oNMaMfQS6lrUJYMosrxYY0Bv56ByPy3dfThZ9H1MOS2AiHsNVSeVDSdy7iMtC570Dd4phI7Qf+M55BiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574794; c=relaxed/simple;
	bh=+WJXsWmPkv8qPmqFlgO9X2YjkZtyJEMp+62A0gWeEy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek2m4HmX88cqYjO1xoI7CHeGx8pJqUp4HhqcYspADxxhcfeD0H8R+1FKLGJXkXXHfvJXhjUBf/qOoqW3MhcWkwQa1X8Ks84yAdq36qZPv9d1t5WIoWdwaJWs6DwgHce8tDATEFDxh6oPMslWC7eIxtq9adlHBnGYNEYgG1G+1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zmm1t5So; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC453C433F1;
	Mon,  4 Mar 2024 17:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709574793;
	bh=+WJXsWmPkv8qPmqFlgO9X2YjkZtyJEMp+62A0gWeEy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zmm1t5SoSWg5TWVv4z9/VUcIrfLBVtNRL/499Avvx9U/L+UJ/QJsoziZLzI3VEJ8y
	 QkMak2IOrQW/ZS7+LYbeYc1JCebl1UlhBXQIpz9pos1BktgGelbfRucme7bufrvhzL
	 vXBRc/Pe9/fB11p0Ly7dMiFOIIUMNJ+sHY1tUSC4wsEATZmg3ttaKY144uxnxQD9Vo
	 hA9Cv7fD/NohfVP5N3H/hZvI/o9AsQcuYOXxhH8MIt6F6WpcUcNn+cSoYOfc3I7EaC
	 /e86JlItD0ZrfpU/OM4bmSMlhbyKw3KGGVAw70RYOl5rhZzFMdEUKcArpy6OBqhemB
	 7NOV6XOK0lzPg==
Date: Mon, 4 Mar 2024 17:53:08 +0000
From: Simon Horman <horms@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ppp@vger.kernel.org
Subject: Re: [PATCH net-next 3/6] net: ppp: make ppp_class constant
Message-ID: <20240304175308.GP403078@kernel.org>
References: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
 <20240302-class_cleanup-net-next-v1-3-8fa378595b93@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302-class_cleanup-net-next-v1-3-8fa378595b93@marliere.net>

On Sat, Mar 02, 2024 at 02:05:59PM -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the ppp_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Simon Horman <horms@kernel.org>


