Return-Path: <linux-kernel+bounces-110204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FA2885B78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A831C216ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC28615F;
	Thu, 21 Mar 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JNOZGJbA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B53A1DD;
	Thu, 21 Mar 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034006; cv=none; b=KP0k4OfMW0u/G5zl/JAtJoPvvVxCWqIIswClDnijB1Q94H+GaArA+TlMQVSp+mYVDSwbzX0Qrm6rkxjPuSnx2WimDsxZYPJIUkVu7f4q7vhL+hOri8icCqOhBZCVG0trihsgBNJvQTKkqkSpZWXDxtiSPQ2eiXdJ1Z+Jd39d7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034006; c=relaxed/simple;
	bh=Zf2Utwr6ymf8HcRwjRD2ylU4Hj4Efc7/vHlSOdqgPU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uqw5hl5PcZQJfDgf+KRMoOvfwrCjzqFYNwJxD5me2/7z4dAVuNbzTK+6TF3bm4Axl/3CxWRzsrlI9TVBtKukLJJ2bVyIeONBrcH/98bpN9dcoLAuPJnU4QK4hS92Cy+e+VWOMmdzKI5ySZGZKEt6AJMes0U5gyVXlLepyaaNRfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JNOZGJbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFD6C433C7;
	Thu, 21 Mar 2024 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711034006;
	bh=Zf2Utwr6ymf8HcRwjRD2ylU4Hj4Efc7/vHlSOdqgPU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNOZGJbAVGegSQbXscqp3A9i5znUB9xh5fZ4I4ElpknstGceXdD6K44VrjKFm8Alm
	 gh0Ahvi3czfnD2V6qh9RcpuV+wds5Os0Mst4ig1DqetkIF9jbo42h9yK4tLbdA2M3g
	 jS4OLl/TtjErT7jLSJZP0NJ2AzDQ27TENo8wz3EQ=
Date: Thu, 21 Mar 2024 16:13:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] speakup: Fix warning for label at end of compound statement
Message-ID: <2024032108-thus-herbal-501b@gregkh>
References: <Zfwv2y7P7BneKqMZ@kroah.com>
 <20240321134831.GA2762840@dev-arch.thelio-3990X>
 <2024032107-upstart-dragonfly-e346@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024032107-upstart-dragonfly-e346@gregkh>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

Label at end of compound statements is a C2x extension, so add an empty instruction.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 807977260ae4 ("speakup: Add /dev/synthu device")
Closes: https://lore.kernel.org/oe-kbuild-all/202403090122.cpUNsozM-lkp@intel.com/
Link: https://lore.kernel.org/r/20240309203549.jj2l6epnznyjsrje@begin
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Linus,

  Here's the fix for clang on top of the char-misc-next branch if you
  pull from it, or I can integrate it in and send a new pull request,
  your choice.

  thanks,

  greg k-h

 drivers/accessibility/speakup/devsynth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accessibility/speakup/devsynth.c b/drivers/accessibility/speakup/devsynth.c
index da4d0f6aa5bf..674204ee5a85 100644
--- a/drivers/accessibility/speakup/devsynth.c
+++ b/drivers/accessibility/speakup/devsynth.c
@@ -108,6 +108,7 @@ static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
 				break;
 			}
 drop:
+			;
 		}
 
 		count -= bytes;
-- 
2.44.0


