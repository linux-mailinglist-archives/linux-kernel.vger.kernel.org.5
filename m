Return-Path: <linux-kernel+bounces-33976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DC783713F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7ED028F5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA30E4BA98;
	Mon, 22 Jan 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9u2NoCl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39864B5B5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947756; cv=none; b=ty7y+YZKDYqKtT1u9QA0YXSf0yRG2gPSRtSfUj/yfjd06aNW9QaTAbGWv3WRHfYjF3uzneEI1aoGn64A1iRqUXg9w7rU4obnyVTOb3GdP0DKCoiRRXmtA8M2b91yl0a6fAOdsfxMYLU7yP5IWdA8yVJWP0XY4/39pePNiJ80RWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947756; c=relaxed/simple;
	bh=xYsOp0Tk8CxfErW9ndj/ZZh4AQhtBNipUfa73tFsnSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4bISt5HclR7EdIwlpEngbYEoVLVNm17YdN8pHJM3HFOCYrUPGLFbPPqTnoaQQrV0C2/1zFnZnSgQ1XeCgDsObOtx/wrG0DiT3QL2N5hUkUf1U0IjBHd+r2nv/yWxAn9Yzbb1dzoBLiU9hHFAK0UF4RN5ged6aWHLfIXCE0gSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9u2NoCl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705947753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSO+yMs9xgoj4SVBxKHNNZsz8CFzHKkKh5JTeSlWjgQ=;
	b=M9u2NoClZ9MYQvWyjsc34ninadYJZ/JuWNgT6PttbhyER7S7jzwAuIOP1PG1W1hvkK6Jkr
	G6k+sD5bLZU90lj0PORUJq2JKyPj0cf0VVCE8y/cgj8z8ke2ZZ2w9XXsnrmJQfmjwzpzdQ
	AhJ9nVZ+2QZUBUHP3sssbgFTI9ZJT/M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-sTgy8nB2N2u3wr9g8-SUNQ-1; Mon,
 22 Jan 2024 13:22:30 -0500
X-MC-Unique: sTgy8nB2N2u3wr9g8-SUNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F78F3C2A1C4;
	Mon, 22 Jan 2024 18:22:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.175])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 11CC03C2E;
	Mon, 22 Jan 2024 18:22:26 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: masahiroy@kernel.org
Cc: dcavalca@meta.com,
	jtornosm@redhat.com,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	nicolas@fjasle.eu,
	stable@vger.kernel.org
Subject: Re: [PATCH V5 1/2] rpm-pkg: simplify installkernel %post
Date: Mon, 22 Jan 2024 19:22:24 +0100
Message-ID: <20240122182225.17944-1-jtornosm@redhat.com>
In-Reply-To: <CAK7LNAQCiBtQ3kQznPDKtkD83wpCzodPVDs8eFnfnx5=Y8E5Cw@mail.gmail.com>
References: <CAK7LNAQCiBtQ3kQznPDKtkD83wpCzodPVDs8eFnfnx5=Y8E5Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

> Those installed files should be removed by %ghost markers.
> I already have a local patch to do this.
> (see the attachment)
I like the idea of your new patch, a lot of things can be fixed in that way.
Ok, I will remove the extra code to remove (%preun) in the patch.
Just a comment about your patch: for openSUSE /boot/initramfs-* files are
called /boot/initrd-* and maybe someone would not require it (i.e. embedded
systems). If it is created it is normally removed and it might not be
necessary (although I like your idea to control it).

> I just asked you to fix up the code as I suggested in v4.
Now I understand why no code was added in %preun.
Ok, your suggestion was very good, but let me try and explain better with
commands what I would like to fix after next point. When I said 'update'
wasn't clear, I think.
If it doesn't fit with your idea or global usage, I will include your
suggestion like it is.

> For me (on Fedora 39 and openSUSE Tumbleweed), rpm fails due to file conflict.
> 
> vagrant@opensuse-tumbleweed20231218:~> sudo rpm -i
> kernel-6.7.0_12924_g660a5f4a53e7-4.x86_64.rpm
> file /lib/modules/6.7.0-12924-g660a5f4a53e7/vmlinuz from install of
> kernel-6.7.0_12924_g660a5f4a53e7-4.x86_64 conflicts with file from
> package kernel-6.7.0_12924_g660a5f4a53e7-3.x86_64
> 
> So, this does not happen.
I was refering to the cases when zypper is used to install a new kernel with
the same release and different build number or when 'rpm -i --replacefiles' 
is used (in this case it would be necessary to remove the old kernel with
'rpm -e --justdb' too).
In this cases we only need the possibility of copying the files from the new
package and not only if they don't exist.
I have thought about an easy way (no extra or problematic command) and I think
I have it.
In addition to your suggestion (if the file does not exit in /boot), I will
just compare the file in /boot with the file in /lib/modules/%{KERNELRELEASE}
and if it is not the same, we allow copying:
%post
if [ -x /usr/bin/kernel-install ]; then
        /usr/bin/kernel-install add %{KERNELRELEASE} /lib/modules/%{KERNELRELEASE}/vmlinuz
fi
for file in vmlinuz System.map config; do
        if [ ! -e "/boot/${file}-%{KERNELRELEASE}" ] || ! cmp --silent "/lib/modules/%{KERNELRELEASE}/${file}" "/boot/${file}-%{KERNELRELEASE}"; then
                cp "/lib/modules/%{KERNELRELEASE}/${file}" "/boot/${file}-%{KERNELRELEASE}"
        fi
done

Let me try with a new patch to know your opinion.

Thanks

Best regards
José Ignacio




