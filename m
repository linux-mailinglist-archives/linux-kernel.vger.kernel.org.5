Return-Path: <linux-kernel+bounces-58864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B61884EDA6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D44281CE9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAE0535D3;
	Thu,  8 Feb 2024 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+V7o4Iq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0C535A9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434252; cv=none; b=CAWBTNiVq6OcLTICzvQSAAXbs/53LQZjO6HNXrRMW1SRJaEpe6wkQuUF+41qsAVcF6emoBQAuMgNzuhJyhYGSgIz0xIUivq75T+KHcHSc8Mr4zJNULQhDeASshv3C5suyTIGdj9IzEcIinwG8McMn2Jo1qgfIzvHsFgrKK+16Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434252; c=relaxed/simple;
	bh=pozcPawVgen/slB+DQSUq4+jkGQPdUpUTJU8TxQhDug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAxqOZhUu7mBAw6nKlyJTkeMK7haWMvd1QomSMYhHzwMsUgb7EmG+aK3OUi7f7PAYUXipHAdYWZBQcvElCHW0sn9ZobsQMp6V53gmA0JcbKn9oNKHKYIK/47U0g1VKi+4Hm29ij9pUUEMKDYFfOAipQ1+VKmSMKJTKaQeaSWBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+V7o4Iq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707434249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjac+eipC+C+UjoWLsy7Pmzz3w7dmXMlA58gqW1bI9Q=;
	b=Y+V7o4IqgjTkoyuEg9MhuUEDYKuDhGPYMWj3YkmgTQjOP3u2Z8uuuqxxR74JNjO3lf9Dng
	aK9CI9SW/Xg2gY3ZG+/b4vIQhVRbpyxi6d81g9NXSMB0ZBb8gk5FyqJNm33qY7FOSKanYf
	72LEXuXdQF5h4MsgUrmSQDxtJe/f0OM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ijqHMpqCN2Cd0cVNi816Hg-1; Thu, 08 Feb 2024 18:17:26 -0500
X-MC-Unique: ijqHMpqCN2Cd0cVNi816Hg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAE41848C05;
	Thu,  8 Feb 2024 23:17:25 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 06A23400D783;
	Thu,  8 Feb 2024 23:17:25 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1) with ESMTPS id 418NHOAi337731
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 18:17:24 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1/Submit) id 418NHNh6337729;
	Thu, 8 Feb 2024 18:17:23 -0500
Date: Thu, 8 Feb 2024 18:17:23 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, mpatocka@redhat.com, heinzm@redhat.com,
        xni@redhat.com, blazej.kucman@linux.intel.com, agk@redhat.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev, jbrassow@f14.redhat.com,
        neilb@suse.de, shli@fb.com, akpm@osdl.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v5 00/14] dm-raid/md/raid: fix v6.7 regressions
Message-ID: <ZcVhA_IqXH2Pg79t@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <Zb2wxIpf7uYV6Vya@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <528ce926-6f17-c1ea-8e77-c7d5d7f56022@huaweicloud.com>
 <ZcE4mGXCDwjqBXgf@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <1fdbfcf8-1ee9-4079-e84e-6e2c1121491b@huaweicloud.com>
 <ZcGuRIrZJaEtXjPh@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <CAPhsuW6arbEmRUK3xG1XVjra3BtSx9_wFe+QKDBbTgb3DgYXig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6arbEmRUK3xG1XVjra3BtSx9_wFe+QKDBbTgb3DgYXig@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Thu, Feb 08, 2024 at 12:04:45AM -0800, Song Liu wrote:
> Hi Benjamin,
> 
> On Mon, Feb 5, 2024 at 7:58 PM Benjamin Marzinski <bmarzins@redhat.com> wrote:
> >
> > On Tue, Feb 06, 2024 at 09:36:18AM +0800, Yu Kuai wrote:
> > > Hi!
> > >
> > > 在 2024/02/06 3:35, Benjamin Marzinski 写道:
> > > > Could you run the test with something like
> > > >
> > > > # make check_local T=lvconvert-repair-raid.sh VERBOSE=1 > out 2>&1
> > > >
> > > > and post the output.
> > >
> > > Attached is the output from my VM.
> >
> > Instead of running the tests from the lvm2 git repo, if you run
> >
> > # make -C test install
> >
> > to install the tests, and then create a results directory and run the
> > test from there, do you still see the error in the 6.6 kernel?
> >
> > # make ~/results
> > # cd ~/results
> > # lvm2-testsuite --only lvconvert-repair-raid.sh
> >
> > Running the tests this way will test the installed lvm2 binaries on your
> > system, instead of the ones in the lvm2 git repo. They may be compiled
> > differently.
> 
> I am not able to get reliable results from shell/lvconvert-repair-raid.sh
> either. For 6.6.0 kernel, the test fails. On 6.8-rc1 kernel, the test fails
> sometimes.
> 
> Could you please share more information about your test setup?
> Specifically:
> 1. Which tree/branch/tag are you testing?
> 2. What's the .config used in the tests?
> 3. How do you run the test suite? One test at a time, or all of them
> together?
> 4. How do you handle "test passes sometimes" cases?

So, I have been able to recreate the case where lvconvert-repair-raid.sh
keeps failing. It happens when I tried running the reproducer on a virtual
machine made using a cloud image, instead of one that I manually
installed. I'm not sure why there is a difference. But I can show you
how I can reliably recreate the errors I'm seeing.


Create a new Fedora 39 virtual machine with the following commands (I'm
not sure if it is possible to reproduce this on a machine using less
memory and cpus, but I can try that if you need me to. You probably also
want to pick a faster Fedora Mirror for the image location):
# virt-install --name repair-test --memory 8192 --vcpus 8 --disk size=40 --graphics none --extra-args "console=ttyS0" --osinfo detect=on,name=fedora-unknown --location https://download.fedoraproject.org/pub/fedora/linux/releases/39/Server/x86_64/os/

Install to the whole virtual drive, using the default LVM partitioning.
Then ssh into the VM and run the following commands to setup the
lvm2-testsuite and 6.6.0 kernel:

# dnf upgrade grub2
# dnf install -y git gcc bc flex make bison openssl openssl-devel dwarves zstd elfutils-libelf-devel libaio-devel lvm2 g++
# git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
# git clone git://sourceware.org/git/lvm2.git
# cd ~/lvm2
# ./configure
# make
# cd ~/linux
# git checkout -b ver6.6 v6.6
# cp /boot/config-`uname -r` .config
# make olddefconfig
# modprobe -a dm_raid dm_delay ext4 raid1 raid10 brd
# yes "" | make localmodconfig
# make -j8
# make modules_install
# make install
# reboot

ssh back into the VM, and run the following commands to run
lvm2-testsuite:

# mount -o remount,dev /tmp
# cd ~/lvm2
# make check T=lvconvert-repair-raid.sh

This should always pass. I ran it 100 times without failure.

To test the patched kernel, run:

# cd ~/linux
# git checkout -b dmraid-fix-v5 v6.8-rc3
# git am ~/dmraid-fix-v5.mbox  ***Apply the v5 patches***
# make olddefconfig
# make -j8
# make modules_install
# make install
# reboot

Rerun the lvm2-testsuite with the same commands as before:

# mount -o remount,dev /tmp
# cd ~/lvm2
# make check T=lvconvert-repair-raid.sh

This fails about 20% of the time, usually at either line 146 or 164. You
can check by running the following command when the test fails.

# grep "STACKTRACE()" ~/lvm2/test/results/ndev-vanilla\:shell_lvconvert-repair-raid.sh.txt
[ 0:13.152] ## 1 STACKTRACE() called from /root/lvm2/test/shell/lvconvert-repair-raid.sh:146

Let me know if you have any questions, or if this doesn't work for you.

-Ben

> Thanks,
> Song


