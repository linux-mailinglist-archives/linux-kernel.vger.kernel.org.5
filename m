Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AAD7EADAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjKNKLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:11:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04D0191
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:11:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49610C4339A;
        Tue, 14 Nov 2023 10:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699956689;
        bh=zGs6JtemmWNXPMyvfqRGX+/e8iMpic7onfI+M/xVR8o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=El2v86ckpwd0jtGV3LZgmLp9h3A5ATu9xUmLYCXD71afVg6EV3RkuHO80c1BEn/lI
         sZAkj7Elei3JZ9p1orT9MSQLlLI+nfYkZnlKfdthwIxpzPaH7wApQMBJe/m686XYxn
         caZfDHFEsUfZLWbzrVIwLqAds+HB4kB0g/jzS6uT/eDLxAQ9m/AE7jPxx/a3dtNK9D
         c5v/FxLkm4ow17kyC+HZmml11UHeRWGWzM2XfnvDBEJbaYQUEnMReP5FGfgeKjpW2Z
         w4W2R5qcQm/D6EUZdixjCxQGzxQCbcdIVYHt4E6MTrVH8ZP5P+JhXKyYYNIix7mQxL
         YfpsqJ9Q98Lpw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1e98e97c824so3288706fac.1;
        Tue, 14 Nov 2023 02:11:29 -0800 (PST)
X-Gm-Message-State: AOJu0YytRL4FSEjp6q7nrmqtPKEGHwqMawQPwIHBHIpL2c4BkPtAECyF
        XJZTHbh5lgP8+jPpq8rAvVmzqWtyYh5pDUXGxPI=
X-Google-Smtp-Source: AGHT+IGVNLiSSPXkB16ead1lNSz8KUJaCr7KrwMdMZaQOowkfHCy3EqHU97pxaa8OeDPWAe5erxvD44GDnSjdJ8EnXI=
X-Received: by 2002:a05:6871:4009:b0:1d5:8d6a:18f0 with SMTP id
 kx9-20020a056871400900b001d58d6a18f0mr1067368oab.27.1699956688295; Tue, 14
 Nov 2023 02:11:28 -0800 (PST)
MIME-Version: 1.0
References: <20231027193016.27516-1-quic_johmoo@quicinc.com> <20231027193016.27516-2-quic_johmoo@quicinc.com>
In-Reply-To: <20231027193016.27516-2-quic_johmoo@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Nov 2023 19:10:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNATWk8psXZvsHXNwxNt9=sUi3J0qOA-P4ceOKqBuS1_VJQ@mail.gmail.com>
Message-ID: <CAK7LNATWk8psXZvsHXNwxNt9=sUi3J0qOA-P4ceOKqBuS1_VJQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] check-uapi: Introduce check-uapi.sh
To:     John Moon <quic_johmoo@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Dodji Seketeli <dodji@redhat.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Jordan Crouse <jorcrous@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 4:31=E2=80=AFAM John Moon <quic_johmoo@quicinc.com>=
 wrote:
>
> While the kernel community has been good at maintaining backwards
> compatibility with kernel UAPIs, it would be helpful to have a tool
> to check if a commit introduces changes that break backwards
> compatibility.
>
> To that end, introduce check-uapi.sh: a simple shell script that
> checks for changes to UAPI headers using libabigail.
>
> libabigail is "a framework which aims at helping developers and
> software distributors to spot some ABI-related issues like interface
> incompatibility in ELF shared libraries by performing a static
> analysis of the ELF binaries at hand."
>
> The script uses one of libabigail's tools, "abidiff", to compile the
> changed header before and after the commit to detect any changes.
>
> abidiff "compares the ABI of two shared libraries in ELF format. It
> emits a meaningful report describing the differences between the two
> ABIs."
>
> The script also includes the ability to check the compatibility of
> all UAPI headers across commits. This allows developers to inspect
> the stability of the UAPIs over time.
>
> Signed-off-by: John Moon <quic_johmoo@quicinc.com>
> ---
>     - Add abidiff suppressions to filter out common things like enum
>       variants named .*_MAX being changed and expansion into padding
>       fields.
>     - Bump minimum abidiff version to 2.4 to accomodate new
>       suppressions.
>     - Add option (-i) to suppress ambiguous breaking changes.
>     - Remove printing of full file diffs when ABI breakage is found
>       as this was too noisy.
>     - Wait for all files to be checked before printing results as
>       printing from parallel threads was garbling output.
>     - Suppress all output when -q is passed.
>     - Avoid messing up user's git tree by using "git archive" instead
>       of checking out references.



The code looks almost good to me.

(I left some more comments below, but they are minor).



Greg,
Could you check the output from the tool?
Is it OK with you?












>
>  scripts/check-uapi.sh | 585 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 585 insertions(+)
>  create mode 100755 scripts/check-uapi.sh
>
> diff --git a/scripts/check-uapi.sh b/scripts/check-uapi.sh
> new file mode 100755
> index 000000000000..bcb03c8dae60
> --- /dev/null
> +++ b/scripts/check-uapi.sh
> @@ -0,0 +1,585 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Script to check commits for UAPI backwards compatibility
> +
> +set -o errexit
> +set -o pipefail
> +
> +print_usage() {
> +       name=3D$(basename "$0")
> +       cat << EOF
> +$name - check for UAPI header stability across Git commits
> +
> +By default, the script will check to make sure the latest commit (or cur=
rent
> +dirty changes) did not introduce ABI changes when compared to HEAD^1. Yo=
u can
> +check against additional commit ranges with the -b and -p options.
> +
> +The script will not check UAPI headers for architectures other than the =
one
> +defined in ARCH.
> +
> +Usage: $name [-b BASE_REF] [-p PAST_REF] [-j N] [-l ERROR_LOG] [-i] [-q]=
 [-v]
> +
> +Options:
> +    -b BASE_REF    Base git reference to use for comparison. If unspecif=
ied or empty,
> +                   will use any dirty changes in tree to UAPI files. If =
there are no
> +                   dirty changes, HEAD will be used.
> +    -p PAST_REF    Compare BASE_REF to PAST_REF (e.g. -p v6.1). If unspe=
cified or empty,
> +                   will use BASE_REF^1. Must be an ancestor of BASE_REF.=
 Only headers
> +                   that exist on PAST_REF will be checked for compatibil=
ity.
> +    -j JOBS        Number of checks to run in parallel (default: number =
of CPU cores).
> +    -l ERROR_LOG   Write error log to file (default: no error log is gen=
erated).
> +    -i             Ignore ambiguous changes that may or may not break UA=
PI compatibility.
> +    -q             Quiet operation.
> +    -v             Verbose operation (print more information about each =
header being checked).
> +
> +Environmental args:
> +    ABIDIFF  Custom path to abidiff binary
> +    CC       C compiler (default is "gcc")
> +    ARCH     Target architecture of C compiler (default is host arch)



ARCH is not the arch of C compiler.
It is the arch for the UAPI check.

It is better to reword it.






> +
> +Exit codes:
> +    $SUCCESS) Success
> +    $FAIL_ABI) ABI difference detected
> +    $FAIL_PREREQ) Prerequisite not met
> +EOF
> +}
> +
> +readonly SUCCESS=3D0
> +readonly FAIL_ABI=3D1
> +readonly FAIL_PREREQ=3D2
> +
> +# Print to stderr
> +eprintf() {
> +       # shellcheck disable=3DSC2059
> +       printf "$@" >&2
> +}
> +
> +# Expand an array with a specific character (similar to Python string.jo=
in())
> +join() {
> +       local IFS=3D"$1"
> +       shift
> +       printf "%s" "$*"
> +}
> +
> +# Create abidiff suppressions
> +gen_suppressions() {
> +       # Common enum variant names which we don't want to worry about
> +       # being shifted when new variants are added.
> +       local -a enum_regex=3D(
> +               ".*_AFTER_LAST$"
> +               ".*_CNT$"
> +               ".*_COUNT$"
> +               ".*_END$"
> +               ".*_LAST$"
> +               ".*_MASK$"
> +               ".*_MAX$"
> +               ".*_MAX_BIT$"
> +               ".*_MAX_BPF_ATTACH_TYPE$"
> +               ".*_MAX_ID$"
> +               ".*_MAX_SHIFT$"
> +               ".*_NBITS$"
> +               ".*_NETDEV_NUMHOOKS$"
> +               ".*_NFT_META_IIFTYPE$"
> +               ".*_NL80211_ATTR$"
> +               ".*_NLDEV_NUM_OPS$"
> +               ".*_NUM$"
> +               ".*_NUM_ELEMS$"
> +               ".*_NUM_IRQS$"
> +               ".*_SIZE$"
> +               ".*_TLSMAX$"
> +               "^MAX_.*"
> +               "^NUM_.*"
> +       )
> +
> +       # Common padding field names which can be expanded into
> +       # without worrying about users.
> +       local -a padding_regex=3D(
> +               ".*end$"
> +               ".*pad$"
> +               ".*pad[0-9]?$"
> +               ".*pad_[0-9]?$"
> +               ".*padding$"
> +               ".*padding[0-9]?$"
> +               ".*padding_[0-9]?$"
> +               ".*res$"
> +               ".*resv$"
> +               ".*resv[0-9]?$"
> +               ".*resv_[0-9]?$"
> +               ".*reserved$"
> +               ".*reserved[0-9]?$"
> +               ".*reserved_[0-9]?$"
> +               ".*rsvd[0-9]?$"
> +               ".*unused$"
> +       )
> +
> +       cat << EOF
> +[suppress_type]
> +  type_kind =3D enum
> +  changed_enumerators_regexp =3D $(join , "${enum_regex[@]}")
> +EOF
> +
> +       for p in "${padding_regex[@]}"; do
> +               cat << EOF
> +[suppress_type]
> +  type_kind =3D struct
> +  has_data_member_inserted_at =3D offset_of_first_data_member_regexp(${p=
})
> +EOF
> +       done
> +
> +if [ "$IGNORE_AMBIGUOUS_CHANGES" =3D "true" ]; then
> +       cat << EOF
> +[suppress_type]
> +  type_kind =3D struct
> +  has_data_member_inserted_at =3D end
> +  has_size_change =3D yes
> +EOF
> +fi
> +}
> +
> +# Check if git tree is dirty
> +tree_is_dirty() {
> +       ! git diff --quiet
> +}
> +
> +# Get list of files installed in $ref
> +get_file_list() {
> +       local -r ref=3D"$1"
> +       local -r tree=3D"$(get_header_tree "$ref")"
> +
> +       # Print all installed headers, filtering out ones that can't be c=
ompiled
> +       find "$tree" -type f -name '*.h' -printf '%P\n' | grep -v -f "$IN=
COMPAT_LIST"
> +}
> +
> +# Add to the list of incompatible headers
> +add_to_incompat_list() {
> +       local -r ref=3D"$1"
> +
> +       # Start with the usr/include/Makefile to get a list of the header=
s
> +       # that don't compile using this method.
> +       if [ ! -f usr/include/Makefile ]; then
> +               eprintf "error - no usr/include/Makefile present at %s\n"=
 "$ref"
> +               eprintf "Note: usr/include/Makefile was added in the v5.3=
 kernel release\n"
> +               exit "$FAIL_PREREQ"
> +       fi
> +       {
> +               # shellcheck disable=3DSC2016
> +               printf 'all: ; @echo $(no-header-test)\n'
> +               cat usr/include/Makefile
> +       } | SRCARCH=3D"$ARCH" make --always-make -f - | tr " " "\n" \
> +         | grep -v "asm-generic" >> "$INCOMPAT_LIST"
> +
> +       # The makefile also skips all asm-generic files, but prints "asm-=
generic/%"
> +       # which won't work for our grep match. Instead, print something g=
rep will match.
> +       printf "asm-generic/.*\.h\n" >> "$INCOMPAT_LIST"
> +
> +       sort -u -o "$INCOMPAT_LIST" "$INCOMPAT_LIST"
> +       sed -i -e '/^$/d' "$INCOMPAT_LIST"



Maybe, you can move these two lines to the
end of install_headers().

The reason for the duplication is because
run_make_headers_install() is executed twice.

You do not need to sort INCOMPAT_LIST
in the first run of run_make_headers_install().





> +}
> +
> +# Compile the simple test app
> +do_compile() {
> +       local -r inc_dir=3D"$1"
> +       local -r header=3D"$2"
> +       local -r out=3D"$3"
> +       printf "int main(void) { return 0; }\n" | \
> +               "$CC" -c \
> +                 -o "$out" \
> +                 -x c \
> +                 -O0 \
> +                 -std=3Dc90 \
> +                 -fno-eliminate-unused-debug-types \
> +                 -g \
> +                 "-I${inc_dir}" \
> +                 -include "$header" \
> +                 -
> +}
> +
> +# Run make headers_install
> +run_make_headers_install() {
> +       local -r install_dir=3D"$1"



You can call get_header_tree() here,
and pass "$ref" to this function.





> +       make -j "$MAX_THREADS" ARCH=3D"$ARCH" INSTALL_HDR_PATH=3D"$instal=
l_dir" \
> +               headers_install > /dev/null
> +}
> +
> +# Install headers for both git refs
> +install_headers() {
> +       local -r base_ref=3D"$1"
> +       local -r past_ref=3D"$2"
> +
> +       for ref in "$base_ref" "$past_ref"; do
> +               printf "Installing user-facing UAPI headers from %s... " =
"${ref:-dirty tree}"
> +               if [ -n "$ref" ]; then
> +                       git archive --format=3Dtar --prefix=3D"${ref}-arc=
hive/" "$ref" \
> +                               | (cd "$TMP_DIR" && tar xf -)
> +                       (
> +                               cd "${TMP_DIR}/${ref}-archive"
> +                               run_make_headers_install "${TMP_DIR}/${re=
f}/usr"
> +                               add_to_incompat_list "$ref" "$INCOMPAT_LI=
ST"
> +                       )
> +               else
> +                       run_make_headers_install "${TMP_DIR}/${ref}/usr"
> +                       add_to_incompat_list "$ref" "$INCOMPAT_LIST"



If we drop the dirty tree support, we can make the code simpler.

$ref would never become empty, and we would always be able to run
"make headers_install" in the /tmp directory.

("make headers_install" in the working tree would create intermediate
build artifacts in usr/include/)

That is my personal opinion.


If you insist on the dirty tree support,
I will leave it to you.







> +               fi
> +               printf "OK\n"
> +       done
> +}
> +
> +# Print the path to the headers_install tree for a given ref
> +get_header_tree() {
> +       local -r ref=3D"$1"
> +       printf "%s" "${TMP_DIR}/${ref}/usr"
> +}
> +
> +# Check file list for UAPI compatibility
> +check_uapi_files() {
> +       local -r base_ref=3D"$1"
> +       local -r past_ref=3D"$2"
> +       local -r abi_error_log=3D"$3"
> +
> +       local passed=3D0;
> +       local failed=3D0;
> +       local -a threads=3D()
> +       set -o errexit
> +
> +       printf "Checking changes to UAPI headers between %s and %s...\n" =
"$past_ref" "${base_ref:-dirty tree}"
> +       # Loop over all UAPI headers that were installed by $past_ref (if=
 they only exist on $base_ref,
> +       # there's no way they're broken and no way to compare anyway)
> +       while read -r file; do
> +               if [ "${#threads[@]}" -ge "$MAX_THREADS" ]; then
> +                       if wait "${threads[0]}"; then
> +                               passed=3D$((passed + 1))
> +                       else
> +                               failed=3D$((failed + 1))
> +                       fi
> +                       threads=3D("${threads[@]:1}")
> +               fi
> +
> +               check_individual_file "$base_ref" "$past_ref" "$file" &
> +               threads+=3D("$!")
> +       done < <(get_file_list "$past_ref")
> +
> +       for t in "${threads[@]}"; do
> +               if wait "$t"; then
> +                       passed=3D$((passed + 1))
> +               else
> +                       failed=3D$((failed + 1))
> +               fi
> +       done
> +
> +       if [ -n "$abi_error_log" ]; then
> +               printf 'Generated by "%s %s" from git ref %s\n\n' \
> +                       "$0" "$*" "$(git rev-parse HEAD)" > "$abi_error_l=
og"
> +       fi
> +
> +       while read -r error_file; do
> +               {
> +                       cat "$error_file"
> +                       printf "\n\n"
> +               } | tee -a "${abi_error_log:-/dev/null}" >&2
> +       done < <(find "$TMP_DIR" -type f -name '*.error')



Does this produce this deterministic result?


Maybe, adding '| sort' after the 'find' command
will produce the sorted report?













> +
> +       total=3D"$((passed + failed))"
> +       if [ "$failed" -gt 0 ]; then
> +               eprintf "error - %d/%d UAPI headers compatible with %s ap=
pear _not_ to be backwards compatible\n" \
> +                       "$failed" "$total" "$ARCH"
> +               if [ -n "$abi_error_log" ]; then
> +                       eprintf "Failure summary saved to %s\n" "$abi_err=
or_log"
> +               fi
> +       else
> +               printf "All %d UAPI headers compatible with %s appear to =
be backwards compatible\n" \
> +                       "$total" "$ARCH"
> +       fi
> +
> +       return "$failed"
> +}
> +
> +# Check an individual file for UAPI compatibility
> +check_individual_file() {
> +       local -r base_ref=3D"$1"
> +       local -r past_ref=3D"$2"
> +       local -r file=3D"$3"
> +
> +       local -r base_header=3D"$(get_header_tree "$base_ref")/${file}"
> +       local -r past_header=3D"$(get_header_tree "$past_ref")/${file}"
> +
> +       local base_ref_short=3D"${base_ref:-dirty tree}"
> +       if [ "${#base_ref_short}" -ge 40 ]; then
> +               base_ref_short=3D"$(git rev-parse --short "$base_ref_shor=
t")"



I believe this is intended to keep the log short, but
I think we can simply use the ref name passed by the user.
If ${ref} is crazily long, it is a user's fault.







> +       fi
> +
> +       local past_ref_short=3D"$past_ref"
> +       if [ "${#past_ref_short}" -ge 40 ]; then
> +               past_ref_short=3D"$(git rev-parse --short "$past_ref_shor=
t")"
> +       fi
> +
> +       if [ ! -f "$base_header" ]; then
> +               mkdir -p "$(dirname "$base_header")"
> +               printf "=3D=3D=3D=3D UAPI header %s was removed between %=
s and %s =3D=3D=3D=3D" \
> +                       "$file" "$past_ref_short" "$base_ref_short" \
> +                               > "${base_header}.error"
> +               return 1
> +       fi
> +
> +       compare_abi "$file" "$base_header" "$past_header" "$base_ref" "$p=
ast_ref" \
> +               "$base_ref_short" "$past_ref_short"
> +}
> +
> +# Perform the A/B compilation and compare output ABI
> +compare_abi() {
> +       local -r file=3D"$1"
> +       local -r base_header=3D"$2"
> +       local -r past_header=3D"$3"
> +       local -r base_ref=3D"$4"
> +       local -r past_ref=3D"$5"
> +       local -r base_ref_short=3D"$6"
> +       local -r past_ref_short=3D"$7"
> +       local -r log=3D"${TMP_DIR}/log/${file}.log"
> +
> +       mkdir -p "$(dirname "$log")"
> +
> +       if ! do_compile "$(get_header_tree "$base_ref")/include" "$base_h=
eader" "${base_header}.bin" 2> "$log"; then
> +               {
> +                       warn_str=3D$(printf "=3D=3D=3D=3D Could not compi=
le version of UAPI header %s at %s =3D=3D=3D=3D\n" \
> +                               "$file" "$base_ref_short")
> +                       printf "%s\n" "$warn_str"
> +                       cat "$log"
> +                       printf -- "=3D%.0s" $(seq 0 ${#warn_str})
> +               } > "${base_header}.error"
> +               return 1
> +       fi
> +
> +       if ! do_compile "$(get_header_tree "$past_ref")/include" "$past_h=
eader" "${past_header}.bin" 2> "$log"; then
> +               {
> +                       warn_str=3D$(printf "=3D=3D=3D=3D Could not compi=
le version of UAPI header %s at %s =3D=3D=3D=3D\n" \
> +                               "$file" "$past_ref_short")
> +                       printf "%s\n" "$warn_str"
> +                       cat "$log"
> +                       printf -- "=3D%.0s" $(seq 0 ${#warn_str})
> +               } > "${base_header}.error"



You used  >"${base_header}.error" instead of
>"${past_header}.error" here.

I guess it is intentional.



But, I think you can put *.error files
under the ${TMP_DIR}/log/ directory if you save the log
from base_ref and past_ref into the same log file.


For example,


   local -r error_log=3D"${TMP_DIR}/log/${file}.error"


Then,

    {
          ...

    } > "${error_log}"










> +               return 1
> +       fi
> +
> +       local ret=3D0
> +       "$ABIDIFF" --non-reachable-types \
> +               --suppressions "$SUPPRESSIONS" \
> +               "${past_header}.bin" "${base_header}.bin" > "$log" || ret=
=3D"$?"
> +       if [ "$ret" -eq 0 ]; then
> +               if [ "$VERBOSE" =3D "true" ]; then
> +                       printf "No ABI differences detected in %s from %s=
 -> %s\n" \
> +                               "$file" "$past_ref_short" "$base_ref_shor=
t"
> +               fi
> +       else
> +               # Bits in abidiff's return code can be used to determine =
the type of error
> +               if [ $((ret & 0x2)) -gt 0 ]; then
> +                       eprintf "error - abidiff did not run properly\n"
> +                       exit 1
> +               fi
> +
> +               if [ "$IGNORE_AMBIGUOUS_CHANGES" =3D "true" ] && [ "$ret"=
 -eq 4 ]; then
> +                       return 0
> +               fi
> +
> +               # If the only changes were additions (not modifications t=
o existing APIs), then
> +               # there's no problem. Ignore these diffs.
> +               if grep "Unreachable types summary" "$log" | grep -q "0 r=
emoved" &&
> +                  grep "Unreachable types summary" "$log" | grep -q "0 c=
hanged"; then
> +                       return 0
> +               fi
> +
> +               {
> +                       warn_str=3D$(printf "=3D=3D=3D=3D ABI differences=
 detected in %s from %s -> %s =3D=3D=3D=3D" \
> +                               "$file" "$past_ref_short" "$base_ref_shor=
t")
> +                       printf "%s\n" "$warn_str"
> +                       sed  -e '/summary:/d' -e '/changed type/d' -e '/^=
$/d' -e 's/^/  /g' "$log"
> +                       printf -- "=3D%.0s" $(seq 0 ${#warn_str})
> +                       if cmp "$past_header" "$base_header" > /dev/null =
2>&1; then
> +                               printf "\n%s did not change between %s an=
d %s...\n" "$file" "$past_ref" "${base_ref:-dirty tree}"
> +                               printf "It's possible a change to one of =
the headers it includes caused this error:\n"
> +                               grep '^#include' "$base_header"
> +                               printf "\n"
> +                       fi
> +               } > "${base_header}.error"
> +
> +               return 1
> +       fi
> +}
> +
> +# Check that a minimum software version number is satisfied
> +min_version_is_satisfied() {
> +       local -r min_version=3D"$1"
> +       local -r version_installed=3D"$2"
> +
> +       printf "%s\n%s\n" "$min_version" "$version_installed" \
> +               | sort -Vc > /dev/null 2>&1
> +}
> +
> +# Make sure we have the tools we need and the arguments make sense
> +check_deps() {
> +       ABIDIFF=3D"${ABIDIFF:-abidiff}"
> +       CC=3D"${CC:-gcc}"
> +       ARCH=3D"${ARCH:-$(uname -m)}"
> +       if [ "$ARCH" =3D "x86_64" ]; then
> +               ARCH=3D"x86"
> +       fi
> +
> +       local -r abidiff_min_version=3D"2.4"
> +       local -r libdw_min_version_if_clang=3D"0.171"
> +
> +       if ! command -v "$ABIDIFF" > /dev/null 2>&1; then
> +               eprintf "error - abidiff not found!\n"
> +               eprintf "Please install abigail-tools version %s or great=
er\n" "$abidiff_min_version"
> +               eprintf "See: https://sourceware.org/libabigail/manual/li=
babigail-overview.html\n"
> +               return 1
> +       fi
> +
> +       local -r abidiff_version=3D"$("$ABIDIFF" --version | cut -d ' ' -=
f 2)"
> +       if ! min_version_is_satisfied "$abidiff_min_version" "$abidiff_ve=
rsion"; then
> +               eprintf "error - abidiff version too old: %s\n" "$abidiff=
_version"
> +               eprintf "Please install abigail-tools version %s or great=
er\n" "$abidiff_min_version"
> +               eprintf "See: https://sourceware.org/libabigail/manual/li=
babigail-overview.html\n"
> +               return 1
> +       fi
> +
> +       if ! command -v "$CC" > /dev/null 2>&1; then
> +               eprintf 'error - %s not found\n' "$CC"
> +               return 1
> +       fi
> +
> +       if "$CC" --version | grep -q clang; then
> +               local -r libdw_version=3D"$(ldconfig -v 2>/dev/null | gre=
p -v SKIPPED | grep -m 1 -o 'libdw-[0-9]\+.[0-9]\+' | cut -c 7-)"
> +               if ! min_version_is_satisfied "$libdw_min_version_if_clan=
g" "$libdw_version"; then
> +                       eprintf "error - libdw version too old for use wi=
th clang: %s\n" "$libdw_version"
> +                       eprintf "Please install libdw from elfutils versi=
on %s or greater\n" "$libdw_min_version_if_clang"
> +                       eprintf "See: https://sourceware.org/elfutils/\n"
> +                       return 1
> +               fi
> +       fi
> +
> +       if [ ! -d "arch/${ARCH}" ]; then
> +               eprintf 'error - ARCH "%s" is not a subdirectory under ar=
ch/\n' "$ARCH"
> +               eprintf "Please set ARCH to one of:\n%s\n" "$(find arch -=
maxdepth 1 -mindepth 1 -type d -printf '%f ' | fmt)"
> +               return 1
> +       fi
> +
> +       if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
> +               eprintf "error - this script requires the kernel tree to =
be initialized with Git\n"
> +               return 1
> +       fi
> +
> +       if ! git rev-parse --verify "$past_ref" > /dev/null 2>&1; then
> +               printf 'error - invalid git reference "%s"\n' "$past_ref"
> +               return 1
> +       fi
> +
> +       if [ -n "$base_ref" ]; then
> +               if ! git merge-base --is-ancestor "$past_ref" "$base_ref"=
 > /dev/null 2>&1; then
> +                       printf 'error - "%s" is not an ancestor of base r=
ef "%s"\n' "$past_ref" "$base_ref"
> +                       return 1
> +               fi
> +               if [ "$(git rev-parse "$base_ref")" =3D "$(git rev-parse =
"$past_ref")" ]; then
> +                       printf 'error - "%s" and "%s" are the same refere=
nce\n' "$past_ref" "$base_ref"
> +                       return 1
> +               fi
> +       fi
> +}
> +
> +run() {
> +       local base_ref=3D"$1"
> +       local past_ref=3D"$2"
> +       local abi_error_log=3D"$3"
> +       shift 3
> +
> +       if [ -z "$KERNEL_SRC" ]; then
> +               KERNEL_SRC=3D"$(realpath "$(dirname "$0")"/..)"
> +       fi
> +
> +       cd "$KERNEL_SRC"
> +
> +       if [ -z "$base_ref" ] && ! tree_is_dirty; then
> +               base_ref=3DHEAD
> +       fi
> +
> +       if [ -z "$past_ref" ]; then
> +               if [ -n "$base_ref" ]; then
> +                       past_ref=3D"${base_ref}^1"
> +               else
> +                       past_ref=3DHEAD
> +               fi
> +       fi
> +
> +       if ! check_deps; then
> +               exit "$FAIL_PREREQ"
> +       fi
> +
> +       TMP_DIR=3D$(mktemp -d)
> +       readonly TMP_DIR
> +       trap 'rm -rf "$TMP_DIR"' EXIT
> +
> +       readonly INCOMPAT_LIST=3D"${TMP_DIR}/incompat_list.txt"
> +       touch "$INCOMPAT_LIST"
> +
> +       readonly SUPPRESSIONS=3D"${TMP_DIR}/suppressions.txt"
> +       gen_suppressions > "$SUPPRESSIONS"
> +
> +       # Run make install_headers for both refs
> +       install_headers "$base_ref" "$past_ref"
> +
> +       # Check for any differences in the installed header trees
> +       if diff -r -q "$(get_header_tree "$base_ref")" "$(get_header_tree=
 "$past_ref")" > /dev/null 2>&1; then
> +               printf "No changes to UAPI headers were applied between %=
s and %s\n" "$past_ref" "${base_ref:-dirty tree}"
> +               exit "$SUCCESS"
> +       fi
> +
> +       if ! check_uapi_files "$base_ref" "$past_ref" "$abi_error_log"; t=
hen
> +               exit "$FAIL_ABI"
> +       fi
> +}
> +
> +main() {
> +       MAX_THREADS=3D$(nproc)
> +       VERBOSE=3D"false"
> +       IGNORE_AMBIGUOUS_CHANGES=3D"false"
> +       quiet=3D"false"
> +       local base_ref=3D""
> +       while getopts "hb:p:j:l:iqv" opt; do
> +               case $opt in
> +               h)
> +                       print_usage
> +                       exit "$SUCCESS"
> +                       ;;
> +               b)
> +                       base_ref=3D"$OPTARG"
> +                       ;;
> +               p)
> +                       past_ref=3D"$OPTARG"
> +                       ;;
> +               j)
> +                       MAX_THREADS=3D"$OPTARG"
> +                       ;;
> +               l)
> +                       abi_error_log=3D"$OPTARG"
> +                       ;;
> +               i)
> +                       IGNORE_AMBIGUOUS_CHANGES=3D"true"
> +                       ;;
> +               q)
> +                       quiet=3D"true"
> +                       VERBOSE=3D"false"
> +                       ;;
> +               v)
> +                       VERBOSE=3D"true"
> +                       quiet=3D"false"
> +                       ;;
> +               *)
> +                       exit "$FAIL_PREREQ"
> +               esac
> +       done
> +
> +       if [ "$quiet" =3D "true" ]; then
> +               exec > /dev/null 2>&1
> +       fi
> +
> +       run "$base_ref" "$past_ref" "$abi_error_log" "$@"
> +}
> +
> +main "$@"
> --
> 2.17.1
>


--
Best Regards

Masahiro Yamada
