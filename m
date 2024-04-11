Return-Path: <linux-kernel+bounces-140126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575B78A0BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12997285CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3841422DB;
	Thu, 11 Apr 2024 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni5naDon"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556C13E884
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825812; cv=none; b=lmAow0/MofRsaNUn8lDUdzhzio26Eh7d3vVzDZ+rQwthGV5ZJ92PRN1vZMQLVbEQcxMSLGiC+kyzNyfYpa/7JZYaKDka0HSpAF9LAhxPBY/3a9/CZk8C3XbY1b+3NwDq/Gyja5WJPZJ4XTE/4PvNGDblyqq9w1K34ti489PLhbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825812; c=relaxed/simple;
	bh=MiTIYvye3l6B9JzrY4Ir5pDljWirVEULk0X8LUFTE64=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lb3B0cnOEsTJt/BuKB/T8buKiVx2jtbvHz+MS1eMpg6EvcBTzfMTC6hv6FNe+uosDSIjh3iFsjYgdYgoSc7/6a/IUHxunOcHLaqc3IwfHMlDWQS14KrNkEVGBlW1ipewAzofMcUjDfoZKgrI9ePET7Y8m8uIUoXpnmBmleKWPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni5naDon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2716C433C7;
	Thu, 11 Apr 2024 08:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712825812;
	bh=MiTIYvye3l6B9JzrY4Ir5pDljWirVEULk0X8LUFTE64=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Ni5naDon9oxkiHHp2T5IHrRod+YcAco5n2SMcDPM0jghA5h2oHI+JQQ3ysuBQTbuZ
	 Xj+YvoAcDr1ogQCHPscSuPsW/MOnwJcsekgmyCMA8+i3rNTHt6ptI/zcp1ig7qf4h9
	 W26M+qYR209yH8FdAFu3n62hxembeYtw2fhWPM4atHELh74zpSurHAFmr5YzKk82TK
	 dXt9w23gEg9nDpHvxysZcIECw9YjRfX2aLB3ePJf+tt6WY0lZvQNT2RKW+TzBYKPB7
	 Ga7iO1FPJu7OjbcrwhQvWSjR/X672lNQE+lGjjAZ15JVCrjL37tCQrAwtVVtiqyH+r
	 KKbU4JOa6CiiQ==
Message-ID: <27380aa8-4a80-48cc-b4ef-9fe08fe3de82@kernel.org>
Date: Thu, 11 Apr 2024 16:56:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: use folio_test_writeback
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240409203411.1885121-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240409203411.1885121-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/10 4:34, Jaegeuk Kim wrote:
> Let's convert PageWriteback to folio_test_writeback.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

