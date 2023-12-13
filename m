Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E24880FBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377714AbjLMAHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377718AbjLMAG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:06:59 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F711D;
        Tue, 12 Dec 2023 16:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FXY889v1wCRjtooR2/EYQR2p4xIuOC6TaQ69pJbqVUc=; b=WSxI4cRALwEpA7/P5n/LMCrkOA
        wVDhRoN3mgpRMLOSV7aLMX92N/SKUp/7FZIR0RLay7LuwHRUsdZ4RhjypiW4rQuAxNVmJCGxVAkNW
        xFhOWjDpM43gbgqlvZBM8mituZTNlH4qs0fwuBTaPwKlIF4VzzvRYIDTsAGo2Pnmanfu2Chlglog5
        ivcdAzRQRs8PRfdcqXm0yqIIMnPZEnefxPUjl32mL59AMs+PmhXNDN7fbGwWbjh5Fauc7tsJLXP1h
        +qpWpZsiN2aCqKN6nmY0ol3OW5M/l5n0goqkUz09/AIBAgvAX3lDvAA+CcfyYTHQf0PABGkI6OrpY
        4gwXAJBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDCm9-00BWxH-02;
        Wed, 13 Dec 2023 00:06:57 +0000
Date:   Wed, 13 Dec 2023 00:06:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [minixfs] conversion to kmap_local_page()
Message-ID: <20231213000656.GI1674809@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Sat around since March; rebased to 6.7-rc1, the only
change is put_and_unmap_page() renamed to unmap_and_put_page() ;-)
That's a minixfs counterpart of ext2 and sysv patchsets.

	Lives in vfs.git #work.minix, individual patches in
followups.

Shortlog:
Al Viro (4):
      minixfs: use offset_in_page()
      minixfs: change the signature of dir_get_page()
      minixfs: Use dir_put_page() in minix_unlink() and minix_rename()
      minixfs: switch to kmap_local_page()

Diffstat:
 fs/minix/dir.c   | 83 +++++++++++++++++++++++---------------------------------
 fs/minix/namei.c | 12 +++-----
 2 files changed, 38 insertions(+), 57 deletions(-)
