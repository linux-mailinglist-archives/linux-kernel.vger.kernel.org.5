Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0004F7DA7B8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 17:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjJ1PSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 11:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1PSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 11:18:45 -0400
X-Greylist: delayed 908 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 28 Oct 2023 08:18:42 PDT
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EDE93
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 08:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698505411; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=HUbGmbVlFYl8nabxnsWxpaWme7pBdrnW1r3J6EdPM6/DWL8DqoIxkWSFtNZf41KNaAZGM82WAsrRqMEsJpmpMnrPyD3v9rErDb/PosVPHeq/S47aMQvcg0+ChoPbr3P5nYZhs6utWNCLB0Spshk5/UOQ3gED0rtu1I0IdkwjwB4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1698505411; h=Content-Type:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
        bh=fcAkc404d9Re+yvfwgnNWPLJSHhtmNiRxLjqyviXX6Y=; 
        b=U7mjbJSUbdDpeP5a71MhIzSl20U1qXfGsxbWimg4Kj7K72nXf5cIFxqcGXvKS/BNEgcamc0SxVT9zeX0/K/HphZeg7xNzmFYveJgoaBkvHtDdD9tlp+5SZHrGbelFI+a9H85c/EWJ0oRkBmKswXNCzqyw3vPMJYRlpYNzne4vOI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=rdklein.fr;
        spf=pass  smtp.mailfrom=edou@rdklein.fr;
        dmarc=pass header.from=<edou@rdklein.fr>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1698505411;
        s=zoho; d=rdklein.fr; i=edou@rdklein.fr;
        h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
        bh=fcAkc404d9Re+yvfwgnNWPLJSHhtmNiRxLjqyviXX6Y=;
        b=O32o+kpg7ieQq+Eaf89CGC8y5//llYVYMuQ0VmKMxvDSDik/HhEldODR9Sk4UvJD
        HnZ89i7Jm56dVcfXc8vdhvLhZFIrMEl2mrw2W6UQhaH4CTTCACut+Uw8iOefjDJH5K6
        Z4cbVotHm535CA1lQ8iiZ9y5ZIrzTtVS7BodXjySSmPaTsENM960gZ3ZEohS3OQUZzJ
        SI9D0QJHzR7dGc+FU3bHbFVXOY6w/nHHPMZ0B3POGCugD85TYPBUwr2XsOGxgt6emwO
        HiPHz1tjipHvvpm8ibGK7td+lLWeyItcewKa/uY2nrYxoYXXtF91yMYyogxQT9N+LLT
        N4mFU5+GZQ==
Received: from venerable (dl977-h01-176-145-83-212.dsl.sta.abo.bbox.fr [176.145.83.212]) by mx.zoho.eu
        with SMTPS id 1698505408734190.88544507003803; Sat, 28 Oct 2023 17:03:28 +0200 (CEST)
User-agent: mu4e 1.8.9; emacs 28.2
From:   Edouard Klein <edou@rdklein.fr>
To:     linux-kernel@vger.kernel.org
Subject: Mounting a 9P FS from inside a user NS ?
Date:   Sat, 28 Oct 2023 16:39:35 +0200
Message-ID: <87zg02bxhd.fsf@rdklein.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel Gurus,

I would like to mount 9P filesystems from inside user namespaces, in
order to replicate Plan 9's default per-process view of the filesystem,
with 9P as a glue to mount part of one process' fs in another process'
fs.

From what I understand, if I create a user- and mount- namespace, I
would be able to unprivilegially mount FSs in it. But only if those FS
have been deemed safe, blessed by the FS_USERNS_MOUNT flag.

For example, tmpfs is a safe FS, and I can do:
unshare --user --map-root-user --mount
mount -t tmpfs tmpfs mnt/mnt1/

and it works.

However, if I do:
unshare --user --map-root-user --mount
mount -t 9p -o trans=unix /run/9p/srv4 mnt/mnt1

I get  mount: /home/edouard/mnt/mnt1: permission denied.

My question is: Are there currently any plans to make v9fs a
FS_USERNS_MOUNT-flagged, safe filesystem ?

If not, is it because of a fundamental design flaw somewhere that make
v9fs less safe than e.g. FUSE, which AFAIK, is deemed safe ?

Or is it because nobody ever got around to it ?

This 2018 thread:
https://lore.kernel.org/all/39b08c53-3449-3164-c1b1-44ac587dd4ea@metux.net/T/
ended with
> plan9fs would also be a candidate for that kind of treatment [being
> allowed for unprivileged mounts] if it had a maintainer.
>

Is this still true ? I did not know v9fs was unmaintained.

How big of a change would making v9fs FS_USERNS_MOUNT-flagged be ? Would
anybody here be open to guide an effort made (by me or anybody else) to
implement this change ?


Last question: I think I can temporarily get by by writing a FUSE
wrapper for 9P2000.L (the current wrappers, 9pfs and plan9port's 9pfuse
only speak 9P2000). Is there an easier temporary solution ?

Thank you for your time and hard work around the kernel.

Cheers,

Edouard.

P.S. Please keep me in CC of the replies if you can.
