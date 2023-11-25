Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD46D7F8E78
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 21:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjKYUKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 15:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjKYUKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 15:10:13 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D87E1;
        Sat, 25 Nov 2023 12:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Oif89apAGYgGnDl0vJMd7EqSUxKrNFIEx0+6HyACgJ8=; b=aRn1XupieKieAwUmxQOvJGQjKt
        t1hEjUhurIhjMcjA1qqBfMFvJOOENq58MfXV8eD+910i3kEz1M8et6gutiSMdySwzMg49yOrPa5cX
        8pAYwlTuOv4VicS1DwmGZ6PeoQRnh/D3sHmfmL0n4NV4pDkEN7ra7EFsI+yYgtwaWKVzCN355h9++
        Qwv+Nz+YtHl6Iwn+3AzrXKUJmcaQFDTu0pisiSWfBH9io43h931RUMsYVZVgeMoePc2vC21eOeXlI
        EKspJ+HV+t3YHaXBhr0zKmRo+mUS7sjMmTBWvLw50luyiPov4Q5XzrtwQpCmpBNbdx7avhmTrbDZR
        xNeeveBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6yyl-003A29-2N;
        Sat, 25 Nov 2023 20:10:15 +0000
Date:   Sat, 25 Nov 2023 20:10:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mo Zou <lostzoumo@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCHES v2][CFT] rename deadlock fixes
Message-ID: <20231125201015.GA38156@ZenIV>
References: <20231122193028.GE38156@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122193028.GE38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated variant forced-pushed into #work.rename; changes since v1:
	* rebased on top of #merged-selinux, to avoid a bisection hazard;
selinuxfs used to abuse lock_rename() badly enough to trigger the checks
in the last commit.  Fixed in #merged-selinux (which consists of a commit
already in selinux git tree), and rebase on top of that does not require
any changes in the series.
	* (hopefully) fixed the markup in directory-locking.rst.  I would
really appreciate if somebody familiar with reST took a look at that.
	* fixed another part of directory-locking.rst, not touched in v1 -
the proof that operations will not introduce loops if none had been present
should've been updated when RENAME_EXCHANGE got introduced; it hadn't been.
Rewritten.

Same branch, same overall description, individual patches in followups.
