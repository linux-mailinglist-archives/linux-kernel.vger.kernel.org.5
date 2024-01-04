Return-Path: <linux-kernel+bounces-17049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F5482479D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A85C285082
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D2828DD2;
	Thu,  4 Jan 2024 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5xFB4NA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD828DC9;
	Thu,  4 Jan 2024 17:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB67DC433C7;
	Thu,  4 Jan 2024 17:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704390076;
	bh=45gUpzqYT6iNQEcLOob1vr6Fx8e/AyvPgBn5FFKgBoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5xFB4NABx9s0keDcrEtsKWLEBxJLYOZyEwFZ393rVuN22lGMLAzGU5dY5zUddHq8
	 2UC47UhIo6b3EfaP2QEC/4lcUZW4/Wz6hZbiWjgkqtNeKPN05sgvW4QfTKlN5udI18
	 yty1n6jfDEsxS2ua/meUChGIn8nmELmnLW0NEmXZHmrKBh1wsRVV34/CHmLGf6wIxY
	 2yJUPAAjawcMExQaev7Qs3Fg09LCBuOuACE+5rWBAulFSGzNKy9zOv9wIhiCEX3F3+
	 obDUNGKn5+yVREjzPPUkhy0eU84PV7dMtfJlWqSr9069ugWlvdQs23LY3uNikorsGb
	 pyPV6go7mMsQQ==
Date: Thu, 4 Jan 2024 17:41:12 +0000
From: Simon Horman <horms@kernel.org>
To: Jonas =?utf-8?Q?Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_sync: Check the correct flag before
 starting a scan
Message-ID: <20240104174112.GJ31813@kernel.org>
References: <20240102180810.54515-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240102180810.54515-1-verdre@v0yd.nl>

On Tue, Jan 02, 2024 at 07:08:08PM +0100, Jonas Dreßler wrote:
> There's a very confusing mistake in the code starting a HCI inquiry: We're
> calling hci_dev_test_flag() to test for HCI_INQUIRY, but hci_dev_test_flag()
> checks hdev->dev_flags instead of hdev->flags. HCI_INQUIRY is a bit that's
> set on hdev->flags, not on hdev->dev_flags though.
> 
> HCI_INQUIRY equals the integer 7, and in hdev->dev_flags, 7 means
> HCI_BONDABLE, so we were actually checking for HCI_BONDABLE here.
> 
> The mistake is only present in the synchronous code for starting an inquiry,
> not in the async one. Also devices are typically bondable while doing an
> inquiry, so that might be the reason why nobody noticed it so far.
> 
> Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>

FWIIW, I agree with this analysis and the proposed fix looks
correct to me.

Reviewed-by: Simon Horman <horms@kernel.org>

I do wonder if it is appropriate to treat this as a bug fix -
is there a use-visible problem? If so, the following seems appropriate to
me.

Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVERY")

...

