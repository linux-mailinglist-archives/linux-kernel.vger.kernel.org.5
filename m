Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E22B768B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGaFzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGaFzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:55:49 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A9AE78
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 22:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690782940; bh=5QtzLncJjPW1Z/AkFRqT4LJ0AxsIBfsBfMzg9sLfXXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dT5hcPdNviYg1RTXNOZr9ggglMMLfYCZ0Jgd8l71USkoTJGPL2oyYHZbnc13fZsW3
         WegPenPnplrg7Rjfidz2L45ijqgSdjclkGlKLyFdoAYmR5hbgw+l1Ih2zTy93x0lcn
         1E9gZ9DOUYnc4PPlRBtBHJ60odnmBXtbe/3WQYfk=
Date:   Mon, 31 Jul 2023 07:55:39 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     tjcw@cantab.net
Cc:     linux-kernel@vger.kernel.org
Subject: Re: vfat file system does not allow a space at the end of a
 directory name
Message-ID: <196f7191-5820-4480-99d3-e7ffc66e9c98@t-8ch.de>
References: <CAC=wTOim6VZM7gKGQ8KuvbVSdmjyg=4G5sFbr+xY89ujPVOq8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC=wTOim6VZM7gKGQ8KuvbVSdmjyg=4G5sFbr+xY89ujPVOq8g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 2023-07-30 23:33:03+0100, Chris Ward wrote:
> I had a zip file (from downloading pictures from Google Photos) where
> some of the directory names had a space at the end. This unzipped fine
> on an ext4 file system, but gave errors when unpacking onto a USB key
> which had a FAT file system.
> 
> On further investigation, file names have the same problem. On my USB key, I get
> 
> tjcw@tjcw-OptiPlex-7010:/media/tjcw/Photos$ touch 'aab '
> touch: setting times of 'aab ': No such file or directory
> tjcw@tjcw-OptiPlex-7010:/media/tjcw/Photos$ echo ok >'aab '
> bash: aab : Invalid argument
> tjcw@tjcw-OptiPlex-7010:/media/tjcw/Photos$ touch 'aab'
> tjcw@tjcw-OptiPlex-7010:/media/tjcw/Photos$ echo ok >'aab'
> tjcw@tjcw-OptiPlex-7010:/media/tjcw/Photos$
> 
> Is this as expected, or is it a bug in the kernel's handling of FAT
> file systems ? Probably the next step is to check the behaviour under
> Microsoft Windows.

AFAIK this is a limitation in the FAT filesystem itself.

The problem is that FAT stores filenames in fixed width fields.
Unused space in these fields is filled with ' '.
This means that storing "foo", "foo " or "foo ". would all result in the
exact same result and it will be impossible to figure out the correct
one afterwards.

From Wikipedia [0]:

    trailing spaces in either the base name or the extension are
    considered to be padding and not a part of the file name

From fs/fat/namei_vfat.c vfat_is_used_badchars():

    last character cannot be space

[0] https://en.wikipedia.org/wiki/Design_of_the_FAT_file_system
