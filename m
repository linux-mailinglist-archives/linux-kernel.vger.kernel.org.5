Return-Path: <linux-kernel+bounces-76015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B821A85F1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F3F1C22DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322F21799E;
	Thu, 22 Feb 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FItXX0at"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743FE290A;
	Thu, 22 Feb 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587347; cv=none; b=huzNtuNCwBsC1jpdtpRY/asAvn31PLigejCDRz6U27IygTbyde+qKlvt5wOMbTDZ2Jgo+FcHPkqEx1iz/BzS6x7ylD046+iEcRj++nzsvaUJGWPaky8vW6PCDhpVM6mjgF1Rwa3rBl6dQogFIPRmprsqxC1qI+pxE4szHpGEfUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587347; c=relaxed/simple;
	bh=/gg6HLF1iVc0ufJm2KfXB3s9/qrmwuJTBEsKy5Ju3CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXyecHVd/dsWkbwE3IhbKVlVHlgJ4fBodjKBslUIrtZAlH6dlPjWrGK78rG/0Dz+oYmdNZxuFWl18f8iBA5SXebmW49iv2aqyWdB/FAjgmLRB973EMNtEfsXNehNK3iRkc8PvYbu+QB56fJa7WqHFILjf+P+GzVZ2tigpTRzGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FItXX0at; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66413C433C7;
	Thu, 22 Feb 2024 07:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708587347;
	bh=/gg6HLF1iVc0ufJm2KfXB3s9/qrmwuJTBEsKy5Ju3CQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FItXX0atqDVJdSO1Mfc/40AiapAWskiKnq9zL2oS2mm9+kzD56o7fNbV91yzoA8eM
	 RAJTFEnxz7s6CLqzlajoYgAwf/uE3XXD/8A9vo8sDLZe9cmqp0JAADAK2cyDnAHXuu
	 G6tmuLc/4/gwZSwk9jY2NdUaPwTnBInpgOW4p9iRkvKZvfbgQF48SI+CBffipUVdef
	 d7OC33Jcba0SJn6ahtRcbU0DvAyyu6SpmrF+pmuCztU3vXKyZ4pge3YvB/XaS9XsWE
	 4aHOfOtOrR2qB2wUg//b5CTkmFXNSjqJ+CRiK+h3p96888P51y/SCMlA/cFrbNv35L
	 IB+IIccn1kCdw==
Message-ID: <12b7187d-73c9-488c-a7cb-93ca31bc74e5@kernel.org>
Date: Thu, 22 Feb 2024 15:35:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix refcount on the metabuf used for inode
 lookup
Content-Language: en-US
To: Sandeep Dhavale <dhavale@google.com>, Gao Xiang <xiang@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: quic_wenjieli@quicinc.com, stable@vger.kernel.org,
 kernel-team@android.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240221210348.3667795-1-dhavale@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240221210348.3667795-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/22 5:03, Sandeep Dhavale wrote:
> In erofs_find_target_block() when erofs_dirnamecmp() returns 0,
> we do not assign the target metabuf. This causes the caller
> erofs_namei()'s erofs_put_metabuf() at the end to be not effective
> leaving the refcount on the page.
> As the page from metabuf (buf->page) is never put, such page cannot be
> migrated or reclaimed. Fix it now by putting the metabuf from
> previous loop and assigning the current metabuf to target before
> returning so caller erofs_namei() can do the final put as it was
> intended.
> 
> Fixes: 500edd095648 ("erofs: use meta buffers for inode lookup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

