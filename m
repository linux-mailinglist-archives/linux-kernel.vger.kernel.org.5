Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A37D80313A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344045AbjLDLEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjLDLE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:04:29 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC09AC0;
        Mon,  4 Dec 2023 03:04:34 -0800 (PST)
Received: from [192.168.1.123] (ip5b4280bd.dynamic.kabel-deutschland.de [91.66.128.189])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CE56761E646C3;
        Mon,  4 Dec 2023 12:03:26 +0100 (CET)
Message-ID: <5cc5076e-3a85-48e2-b75f-a3d1021f531e@molgen.mpg.de>
Date:   Mon, 4 Dec 2023 12:03:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Stefan Krueger <stefan.krueger@aei.mpg.de>
From:   Donald Buczek <buczek@molgen.mpg.de>
Subject: [bcachefs] [bug]: missing subvolume 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reporting to maintainer.pl list, hope that's correct?

Probably, this is a trivial one:
Linux 6.7.0-rc4.

buczek@dose:~$ sudo bcachefs format /dev/vdb
External UUID:                              d5181483-dc0c-4781-a266-ef830fa3c099
Internal UUID:                              d96e4b19-43f3-4a5b-bc5c-3fe2b726b1ef
[...]
buczek@dose:~$ sudo bcachefs mount /dev/vdb /mnt
buczek@dose:~$ sudo chmod a=rwxt /mnt
buczek@dose:~$ mkdir /mnt/d
buczek@dose:~$ bcachefs subvolume snapshot /mnt/d/snp1
BCH_IOCTL_SUBVOLUME_CREATE ioctl error: No such file or directory
buczek@dose:~$ dmesg|tail -10
[ 7477.587299] bcachefs (vdb): mounting version 1.3: rebalance_work
[ 7477.589134] bcachefs (vdb): recovering from clean shutdown, journal seq 14
[ 7477.608861] bcachefs (vdb): alloc_read... done
[ 7477.610525] bcachefs (vdb): stripes_read... done
[ 7477.612037] bcachefs (vdb): snapshots_read... done
[ 7477.644331] bcachefs (vdb): journal_replay... done
[ 7477.645940] bcachefs (vdb): resume_logged_ops... done
[ 7477.650087] bcachefs (vdb): going read-write
[ 7514.113568] bcachefs (vdb): missing subvolume 0
[ 7514.115121] bcachefs (vdb): inconsistency detected - emergency read only
buczek@dose:~$



Best
   Donald

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
