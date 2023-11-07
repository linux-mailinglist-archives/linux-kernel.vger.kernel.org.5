Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10167E3475
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 05:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjKGESX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 23:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjKGESV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 23:18:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AE9110
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 20:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699330651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OEClqip8Hd/4yw5LjGu4+pn6BbKEnTze4Tcl/EjSE1A=;
        b=ghefhjECicNOHDe6F2R7btmcAx3IEyvUmJ5FBEu4nonJzvZ52lv94RAWnozoxV+zJQySl/
        UADRqh+PMbiTaJOy3PRaxOLQPwW5EBnSeflGgTnKJwSaXXCLoUGNt3nDIkDfgoauFgaRfc
        HEbBU4h0tuBOPVjoOnJC3vhV+la1UQw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-13QoEQJrNvy6nUbjCg3Zeg-1; Mon, 06 Nov 2023 23:17:29 -0500
X-MC-Unique: 13QoEQJrNvy6nUbjCg3Zeg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc502d401eso47890525ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 20:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699330648; x=1699935448;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OEClqip8Hd/4yw5LjGu4+pn6BbKEnTze4Tcl/EjSE1A=;
        b=nustBb0pmPQxpfrtIfAZqiqVM+SnzPTcoaoQP91m1H8S2lKoP6+ms9h2h8IH+hygYJ
         kiwqvgiQABXKkMP4SxGAnryHpYU4JVaSrB0SlP7Gb/8C7wddPCJ+7TLEsB89jvyYnBCE
         9Qux+j9pYwnlPIx+Tv5kACRtF0vtDXl0xB5ljJlMYXQx7PpQP+Y/aZAJY2tiR22eWJhb
         HEnTd/2byuiUemM78gLwv6xcAM3/HPvWWfY25Kr/61hQ0KRpJAkVptpfLEF1ESTWs8th
         W4OLvJaRxgg7lS2TS/vdnfzFdGqq4XSaBfnGYazh+/nsPTUvDVe9pBAuU9N97PO93hbd
         A1iQ==
X-Gm-Message-State: AOJu0YyWWO6+iiBB8iYDRZQd37pf/VM/De234YAmMkS16rZLSMTfin9e
        Ynyt5KnJoc7VwN6n/MkSe8gwvLwcq9nPi78n8LXQLNrUFCp/L73a4sFXpxTSF2OWqEsapXht3+t
        rBUNctMI5dVF1FDrbDIz7NMHhTnDRNR0S
X-Received: by 2002:a17:902:da87:b0:1cc:548d:4252 with SMTP id j7-20020a170902da8700b001cc548d4252mr27501631plx.57.1699330647980;
        Mon, 06 Nov 2023 20:17:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/bDSpYLFMGA8/IP0/ZDBgoerLMJpNRCRJpSAHrDXrDr7fFUbf3eUOwgyPRyBg+Ru2wXoVVg==
X-Received: by 2002:a17:902:da87:b0:1cc:548d:4252 with SMTP id j7-20020a170902da8700b001cc548d4252mr27501620plx.57.1699330647618;
        Mon, 06 Nov 2023 20:17:27 -0800 (PST)
Received: from [192.168.68.219] (159-196-82-144.9fc452.per.static.aussiebb.net. [159.196.82.144])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b001c898328289sm6636558plf.158.2023.11.06.20.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 20:17:27 -0800 (PST)
Message-ID: <26101f57-e5b3-e07b-c67f-259ab820cb0d@redhat.com>
Date:   Tue, 7 Nov 2023 12:17:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     autofs mailing list <autofs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Ian Kent <ikent@redhat.com>
Subject: [ANNOUNCE] autofs 5.1.9 release
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

A release is long overdue so here it is, autofs-5.1.9.

There are quite a lot of changes in the release but they are mostly
bug fixes arising from a number significant improvements done over
the last several releases.

Some general performance overheads have crept in over quite a while
and work has been done to improve on it but once the obvious is done
it gets much harder to improve, so that's ongoing as time permits.

autofs
======

The package can be found at:
https://www.kernel.org/pub/linux/daemons/autofs/v5/

It is autofs-5.1.9.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.1.9.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.1.9.tar.gz

Here are the entries from the CHANGELOG which outline the updates:

- fix kernel mount status notification.
- fix fedfs build flags.
- fix set open file limit.
- improve descriptor open error reporting.
- fix root offset error handling.
- fix fix root offset error handling.
- fix nonstrict fail handling of last offset mount.
- dont fail on duplicate offset entry tree add.
- fix loop under run in cache_get_offset_parent().
- bailout on rpc systemerror.
- fix nfsv4 only mounts should not use rpcbind.
- simplify cache_add() a little.
- fix use after free in tree_mapent_delete_offset_tree().
- fix memory leak in xdr_exports().
- avoid calling pthread_getspecific() with NULL key_thread_attempt_id.
- fix sysconf(3) return handling.
- remove nonstrict parameter from tree_mapent_umount_offsets().
- fix handling of incorrect return from umount_ent().
- dont use initgroups() at spawn.
- fix bashism in configure.
- musl: fix missing include in hash.h.
- musl: define fallback dummy NSS config path
- musl: avoid internal stat.h definitions.
- musl: add missing include to hash.h for _WORDSIZE.
- musl: add missing include to log.h for pid_t.
- musl: define _SWORD_TYPE.
- add autofs_strerror_r() helper for musl.
- update configure.
- handle innetgr() not present in musl.
- fix missing unlock in sasl_do_kinit_ext_cc().
- fix a couple of null cache locking problems.
- restore gcc flags after autoconf Kerberos 5 check.
- prepare for OpenLDAP SASL binding.
- let OpenLDAP handle SASL binding.
- configure: LDAP function checks ignore implicit declarations.
- improve debug logging of LDAP binds.
- improve debug logging of SASL binds.
- internal SASL logging only in debug log mode.
- more comprehensive verbose logging for LDAP maps.
- fix invalid tsv access.
- support SCRAM for SASL binding.
- ldap_sasl_interactive_bind() needs credentials for auto-detection.
- fix autofs regression due to positive_timeout.
- fix parse module instance mutex naming.
- serialise lookup module open and reinit.
- coverity fix for invalid access.
- fix hosts map deadlock on restart.
- fix deadlock with hosts map reload.
- fix memory leak in update_hosts_mounts().
- fix minus only option handling in concat_options().
- fix incorrect path for is_mounted() in try_remount().
- fix additional tsv invalid access.
- fix use_ignore_mount_option description.
- include addtional log info for mounts.
- fail on empty replicated host name.
- improve handling of ENOENT in sss setautomntent().
- don't immediately call function when waiting.
- define LDAP_DEPRECATED during LDAP configure check.
- fix return status of mount_autofs().
- don't close lookup at umount.
- fix deadlock in lookups.
- dont delay expire.
- make amd mapent search function name clear.
- rename statemachine() to signal_handler().
- make signal handling consistent.
- eliminate last remaining state_pipe usage.
- add function master_find_mapent_by_devid().
- use device id to locate autofs_point when setting log priotity.
- add command pipe handling functions.
- switch to application wide command pipe.
- get rid of unused field submnt_count.
- fix mount tree startup reconnect.
- fix unterminated read in handle_cmd_pipe_fifo_message().
- fix memory leak in sasl_do_kinit()
- fix fix mount tree startup reconnect.
- fix amd selector function matching.
- get rid entry thid field.
- continue expire immediately after submount check.
- eliminate realpath from mount of submount.
- eliminate root param from autofs mount and umount.
- remove redundant fstat from do_mount_direct().
- get rid of strlen call in handle_packet_missing_direct().
- remove redundant stat call in lookup_ghost().
- set mapent dev and ino before adding to index.
- change to use printf functions in amd parser.
- dont call umount_subtree_mounts() on parent at umount.
- dont take parent source lock at mount shutdown.
- fix possible use after free in handle_mounts_exit().
- make submount cleanup the same as top level mounts.
- add soucre parameter to module functions.
- add ioctlfd open helper.
- make open files limit configurable.
- use correct reference for IN6 macro call.
- dont probe interface that cant send packet.
- fix some sss error return cases.
- fix incorrect matching of cached wildcard key.
- fix expire retry looping.
- allow -null map in indirect maps.
- fix multi-mount check.
- fix let OpenLDAP handle SASL binding.
- always recreate credential cache.
- fix ldap_parse_page_control() check.
- fix typo in create_cmd_pipe_fifo().
- add null check in master_kill().
- be more careful with cmd pipe at exit.
- rename configure.in to configure.ac.
- update autoconf macros.
- update autoconf release.
- update autofs release.

Ian

