Return-Path: <linux-kernel+bounces-88550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531C886E349
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825081C20C6A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B856F515;
	Fri,  1 Mar 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ylv4V3O9"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B46F061
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303112; cv=none; b=bZGDMcbiNOyRBNbHQIXweaDNGsAv+D0dN3gjfviMMkbdhN4uXhBBVSZoQrvPa5QksZmQ9D0wvb2y0wl+6zanikJptBuToAf/bvmmE0PfH6DTZJBHE7mEtxLuyAfiBxWf2s04k0wOLfLZ5/cHIuoNeFqly0vrR3i925u+Ypw6H94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303112; c=relaxed/simple;
	bh=5okDwi/k7eo0OHcemxFpOE6en8LVkUhW41Fp8q/pG3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diIYHyO2SOmSw29lpmZV1Odjv0MBr+q/nm2tplY9o4IG75nHY/5RF5u50nKcpF7sBsJXFCmFyXSW/375d9F3afrpwDfxx+vOYlXxkwnZToTHnDoyQZ2la4vLovkwmL03xsyvv56nSCFX55Pe8OkrFvHolPdIGQhEGyzRd0N21v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Ylv4V3O9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso619748466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709303109; x=1709907909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5okDwi/k7eo0OHcemxFpOE6en8LVkUhW41Fp8q/pG3A=;
        b=Ylv4V3O9EYgKpUfFEacjXsPQpkzJ35hWPBK7pyBIomPjEz3ql96c+ZlvuhQg2s+Mi8
         FrMblwjAAyuOAFngXtJYe6F6bPkO708xXWdB25TxYa3ndZlHVHrYpfJUw6lK6p92cgrP
         RLKfJVRg2R1q5RgvLxV4wi1HqIEiEuWzmQJtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709303109; x=1709907909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5okDwi/k7eo0OHcemxFpOE6en8LVkUhW41Fp8q/pG3A=;
        b=VQellBSZscTXusk3zH2o7K5vkCOuhrKLOdh6luTCIAq3qRHY9wQbk4cSgn7qHi7UCd
         jzgiMOBdiyxWS06xh63k193sp+i4dw1Anzhlcu6Cn0ogBba6rKqCEkTTDu6/qyx2DluN
         sDdRZL2hpG4YLB5vf05+V3DgumQXOum5mYiW4cztBeQOoCNYoBtSfJ7F8SReN8pDF685
         BBwfH+aPEV2Ab1CEM/Xw/Nu3HRtOedq2ydq1a6cxGvjWk33DWE+GjoSzI62VqSupMhYd
         XCyszC0LyiU3g5YAUIQqFYUu52nYN535EdbCqDYw4wV5ctnpC1t+RaNbnFXB33jcvTJi
         aLNw==
X-Forwarded-Encrypted: i=1; AJvYcCVpOUV+GUyi00QHfMLhR5r/ySq4Ha41WgDBlU0sbpjjgDu+Tj/4cqRj3pF4OJ/lpeiKu3CcMg23uWfaIQqMV7ViMPThbZO+nq0ecfW9
X-Gm-Message-State: AOJu0YxcqEt9eOmTgAautIiv6JZOM32FequEfLdGPK10wPS5dqF3ey1c
	vpw4ThXv6jgjO4MLfNA6zeVtcEJz+4OnfuHnc4RAersZ/1LnSRAB8PscfXl8p4SH5sZn92v6gy1
	8SM7KAn7TTV3ZILxKvrg4KA9NtYYz/vrs5owpkw==
X-Google-Smtp-Source: AGHT+IEhsrgq0r/5TG+8I3i+pYsCJeZ2wHcCwGUln1tbl6e7l4aRJSB0dinot2MdM9HMgBMP+IXw43g0gohie9KCMdg=
X-Received: by 2002:a17:906:5ad0:b0:a44:806f:ad56 with SMTP id
 x16-20020a1709065ad000b00a44806fad56mr1493961ejs.11.1709303109066; Fri, 01
 Mar 2024 06:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228144126.2864064-1-houtao@huaweicloud.com> <20240228144126.2864064-4-houtao@huaweicloud.com>
In-Reply-To: <20240228144126.2864064-4-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 1 Mar 2024 15:24:57 +0100
Message-ID: <CAJfpegsSHfO6yMpNAxaZVMvLNub_Kv5rhZQaDuJHNgHpWhpteg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] virtiofs: factor out more common methods for argbuf
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Benjamin Coddington <bcodding@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 15:41, Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Factor out more common methods for bounce buffer of fuse args:
>
> 1) virtio_fs_argbuf_setup_sg: set-up sgs for bounce buffer
> 2) virtio_fs_argbuf_copy_from_in_arg: copy each in-arg to bounce buffer
> 3) virtio_fs_argbuf_out_args_offset: calc the start offset of out-arg
> 4) virtio_fs_argbuf_copy_to_out_arg: copy bounce buffer to each out-arg
>
> These methods will be used to implement bounce buffer backed by
> scattered pages which are allocated separatedly.

Why is req->argbuf not changed to being typed?

Thanks,
Miklos

